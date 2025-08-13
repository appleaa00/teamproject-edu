package org.ruoyi.system.service;

import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.constant.Constants;
import org.ruoyi.common.core.constant.GlobalConstants;
import org.ruoyi.common.core.constant.TenantConstants;
import org.ruoyi.common.core.domain.dto.RoleDTO;
import org.ruoyi.common.core.domain.model.LoginUser;
import org.ruoyi.common.core.enums.DeviceType;
import org.ruoyi.common.core.enums.LoginType;
import org.ruoyi.common.core.enums.TenantStatus;
import org.ruoyi.common.core.enums.UserStatus;
import org.ruoyi.common.core.exception.user.CaptchaException;
import org.ruoyi.common.core.exception.user.CaptchaExpireException;
import org.ruoyi.common.core.exception.user.UserException;
import org.ruoyi.common.core.utils.*;
import org.ruoyi.common.log.event.LogininforEvent;
import org.ruoyi.common.redis.utils.RedisUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.tenant.exception.TenantException;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.system.domain.SysUser;
import org.ruoyi.system.domain.vo.SysTenantVo;
import org.ruoyi.system.domain.vo.SysUserVo;
import org.ruoyi.system.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.Date;
import java.util.List;
import java.util.function.Supplier;

/**
 * 登录校验方法
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Slf4j
@Service
public class SysLoginService {

    private final SysUserMapper userMapper;
    private final ISysPermissionService permissionService;
    private final ISysTenantService tenantService;

    @Value("${user.password.maxRetryCount}")
    private Integer maxRetryCount;
    @Value("${user.password.lockTime}")
    private Integer lockTime;

    /**
     * 登录验证
     *
     * @param username 用户名
     * @param password 密码
     * @param code     验证码
     * @param uuid     唯一标识
     * @return 结果
     */
    public String login(String tenantId, String username, String password, String code, String uuid) {
        SysUserVo user = loadUserByUsername(tenantId, username);//从数据库里根据用户名查询用户信息
        checkLogin(LoginType.PASSWORD, tenantId, username, () -> !BCrypt.checkpw(password, user.getPassword()));//登录校验
        // 此处可根据登录用户的数据不同 自行创建 loginUser
        LoginUser loginUser = buildLoginUser(user);//把返回的user转成一个 LoginUser 对象
        // 生成token
        LoginHelper.loginByDevice(loginUser, DeviceType.PC);//使用 Sa-Token 框架生成 token 并缓存用户

        recordLogininfor(loginUser.getTenantId(), username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success"));
        recordLoginInfo(user.getUserId());//更新数据库中“这个用户最近一次登录时间、IP 地址”等信息
        return StpUtil.getTokenValue();//返回 token 给前端
    }

    public String smsLogin(String tenantId, String phonenumber, String smsCode) {
        // 校验租户
        checkTenant(tenantId);//检查租户是否合法
        // 从数据库中通过手机号查找用户
        SysUserVo user = loadUserByPhonenumber(tenantId, phonenumber);//通过 userMapper.selectOne(...) 实现，查找 sys_user 表中 phonenumber 等于参数的记录。

        checkLogin(LoginType.SMS, tenantId, user.getUserName(), () -> !validateSmsCode(tenantId, phonenumber, smsCode));
        // 此处可根据登录用户的数据不同 自行创建 loginUser
        LoginUser loginUser = buildLoginUser(user);
        // 生成token
        LoginHelper.loginByDevice(loginUser, DeviceType.APP);

        recordLogininfor(loginUser.getTenantId(), user.getUserName(), Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success"));
        recordLoginInfo(user.getUserId());
        return StpUtil.getTokenValue();
    }

    public String emailLogin(String tenantId, String email, String emailCode) {
        // 校验租户
        checkTenant(tenantId);
        // 通过邮箱查找用户
        SysUserVo user = loadUserByEmail(tenantId, email);

        checkLogin(LoginType.EMAIL, tenantId, user.getUserName(), () -> !validateEmailCode(tenantId, email, emailCode));
        // 此处可根据登录用户的数据不同 自行创建 loginUser
        LoginUser loginUser = buildLoginUser(user);
        // 生成token
        LoginHelper.loginByDevice(loginUser, DeviceType.APP);

        recordLogininfor(loginUser.getTenantId(), user.getUserName(), Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success"));
        recordLoginInfo(user.getUserId());
        return StpUtil.getTokenValue();
    }

    /**
     * 退出登录
     */
    public void logout() {
        try {
            LoginUser loginUser = LoginHelper.getLoginUser();
            if (TenantHelper.isEnable() && LoginHelper.isSuperAdmin()) {
                // 超级管理员 登出清除动态租户
                TenantHelper.clearDynamic();
            }
            StpUtil.logout();//删除当前 token
                             //清空 token 对应的 session
                             //当前用户标记为“未登录”
            if (loginUser !=null) {
                recordLogininfor(loginUser.getTenantId(), loginUser.getUsername(), Constants.LOGOUT, MessageUtils.message("user.logout.success"));
            }
        } catch (NotLoginException ignored) {
        }
    }

    /**
     * 记录登录信息
     *
     * @param tenantId 租户ID
     * @param username 用户名
     * @param status   状态
     * @param message  消息内容
     */
    private void recordLogininfor(String tenantId, String username, String status, String message) {
        LogininforEvent logininforEvent = new LogininforEvent();//通过事件机制（event-driven）解耦业务逻辑与日志处理
        logininforEvent.setTenantId(tenantId);
        logininforEvent.setUsername(username);
        logininforEvent.setStatus(status);
        logininforEvent.setMessage(message);
        logininforEvent.setRequest(ServletUtils.getRequest());
        SpringUtils.context().publishEvent(logininforEvent);
    }

    /**
     * 校验短信验证码
     */
    private boolean validateSmsCode(String tenantId, String phonenumber, String smsCode) {
        String code = RedisUtils.getCacheObject(GlobalConstants.CAPTCHA_CODE_KEY + phonenumber);
        if (StringUtils.isBlank(code)) {//如果 Redis 中没找到验证码（说明过期了），就认为验证码 失效。
            recordLogininfor(tenantId, phonenumber, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire"));
            //项目用异步事件方式处理日志，不影响主流程性能。
            throw new CaptchaExpireException();
        }
        return code.equals(smsCode);//code 是从 Redis 拿到的正确验证码
                                    //smsCode 是用户在前端输入的
    }

    /**
     * 校验邮箱验证码
     */
    private boolean validateEmailCode(String tenantId, String email, String emailCode) {
        String code = RedisUtils.getCacheObject(GlobalConstants.CAPTCHA_CODE_KEY + email);
        if (StringUtils.isBlank(code)) {
            recordLogininfor(tenantId, email, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire"));
            throw new CaptchaExpireException();
        }
        return code.equals(emailCode);
    }

    /**
     * 校验验证码
     *
     * @param username 用户名
     * @param code     验证码
     * @param uuid     唯一标识
     */
    public void validateCaptcha(String tenantId, String username, String code, String uuid) {
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + StringUtils.defaultString(uuid, "");
        String captcha = RedisUtils.getCacheObject(verifyKey);
        RedisUtils.deleteObject(verifyKey);
        if (captcha == null) {
            recordLogininfor(tenantId, username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire"));
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha)) {
            recordLogininfor(tenantId, username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error"));
            throw new CaptchaException();
        }
    }

    private SysUserVo loadUserByUsername(String tenantId, String username) {
        //查数据库
        //查找符合条件的第一条用户记录
        /*SELECT user_name, status FROM sys_user
          WHERE tenant_id = ? AND user_name = ?
        */
        SysUser user = userMapper.selectOne(new LambdaQueryWrapper<SysUser>().select(SysUser::getUserName, SysUser::getStatus).eq(TenantHelper.isEnable(), SysUser::getTenantId, tenantId).eq(SysUser::getUserName, username));
        if (ObjectUtil.isNull(user)) {//user == null
            log.info("登录用户：{} 不存在.", username);//log.info(...) 会在控制台打印一条日志，记录失败原因
            throw new UserException("user.not.exists", username);//抛出异常
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {//如果用户被禁用
            log.info("登录用户：{} 已被停用.", username);
            throw new UserException("user.blocked", username);
        }
        if (TenantHelper.isEnable()) {
            return userMapper.selectTenantUserByUserName(username, tenantId);//查完整信息
        }
        return userMapper.selectUserByUserName(username);
    }

    private SysUserVo loadUserByPhonenumber(String tenantId, String phonenumber) {
        SysUser user = userMapper.selectOne(new LambdaQueryWrapper<SysUser>().select(SysUser::getPhonenumber, SysUser::getStatus).eq(TenantHelper.isEnable(), SysUser::getTenantId, tenantId).eq(SysUser::getPhonenumber, phonenumber));
        if (ObjectUtil.isNull(user)) {
            log.info("登录用户：{} 不存在.", phonenumber);
            throw new UserException("user.not.exists", phonenumber);
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", phonenumber);
            throw new UserException("user.blocked", phonenumber);
        }
        if (TenantHelper.isEnable()) {
            return userMapper.selectTenantUserByPhonenumber(phonenumber, tenantId);
        }
        return userMapper.selectUserByPhonenumber(phonenumber);
    }

    private SysUserVo loadUserByEmail(String tenantId, String email) {
        SysUser user = userMapper.selectOne(new LambdaQueryWrapper<SysUser>().select(SysUser::getPhonenumber, SysUser::getStatus).eq(TenantHelper.isEnable(), SysUser::getTenantId, tenantId).eq(SysUser::getEmail, email));
        if (ObjectUtil.isNull(user)) {
            log.info("登录用户：{} 不存在.", email);
            throw new UserException("user.not.exists", email);
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            log.info("登录用户：{} 已被停用.", email);
            throw new UserException("user.blocked", email);
        }
        if (TenantHelper.isEnable()) {
            return userMapper.selectTenantUserByEmail(email, tenantId);
        }
        return userMapper.selectUserByEmail(email);
    }

    /**
     * 构建登录用户
     */
    private LoginUser buildLoginUser(SysUserVo user) {
        LoginUser loginUser = new LoginUser();
        loginUser.setTenantId(user.getTenantId());//复制用户基本信息
        loginUser.setUserId(user.getUserId());
        loginUser.setDeptId(user.getDeptId());
        loginUser.setUsername(user.getUserName());
        loginUser.setAvatar(user.getAvatar());
        loginUser.setUserType(user.getUserType());
        loginUser.setMenuPermission(permissionService.getMenuPermission(user.getUserId()));//根据 userId 查询出用户所有菜单权限编码，设置用户菜单权限
        loginUser.setRolePermission(permissionService.getRolePermission(user.getUserId()));//设置角色权限
        loginUser.setDeptName(ObjectUtil.isNull(user.getDept()) ? "" : user.getDept().getDeptName());//如果部门信息是空的 就设置为空字符串，避免空指针异常，如果不空就取出部门名词
        List<RoleDTO> roles = BeanUtil.copyToList(user.getRoles(), RoleDTO.class);//把 user.getRoles() 中的每个角色对象转换成 RoleDTO 类型（简化），然后设置进 loginUser
        loginUser.setRoles(roles);
        return loginUser;
    }

    /**
     * 记录登录信息
     *
     * @param userId 用户ID
     */
    public void recordLoginInfo(Long userId) {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);//UPDATE sys_user SET ... WHERE user_id = ?
        sysUser.setLoginIp(ServletUtils.getClientIP());
        sysUser.setLoginDate(DateUtils.getNowDate());
        sysUser.setUpdateBy(userId);
        userMapper.updateById(sysUser);
    }

    /**
     * 登录校验
     */
    private void checkLogin(LoginType loginType, String tenantId, String username, Supplier<Boolean> supplier) {
        String errorKey = GlobalConstants.PWD_ERR_CNT_KEY + username;//在 Redis 中存错误次数的钥匙
        String loginFail = Constants.LOGIN_FAIL;

        // 获取用户登录错误次数(可自定义限制策略 例如: key + username + ip)
        Integer errorNumber = RedisUtils.getCacheObject(errorKey);//从 Redis 查询错误次数
        // 锁定时间内登录 则踢出
        if (ObjectUtil.isNotNull(errorNumber) && errorNumber.equals(maxRetryCount)) { //如果之前已经输错了密码，而且达到了最大错误次数，就锁定账号
            recordLogininfor(tenantId, username, loginFail, MessageUtils.message(loginType.getRetryLimitExceed(), maxRetryCount, lockTime));//写日志
            throw new UserException(loginType.getRetryLimitExceed(), maxRetryCount, lockTime);//抛出错误
        }

        if (supplier.get()) {//如果密码错误，就返回 true，进入这个 if
            // 是否第一次
            errorNumber = ObjectUtil.isNull(errorNumber) ? 1 : errorNumber + 1;
            // 达到规定错误次数 则锁定登录
            if (errorNumber.equals(maxRetryCount)) {
                RedisUtils.setCacheObject(errorKey, errorNumber, Duration.ofMinutes(lockTime));
                recordLogininfor(tenantId, username, loginFail, MessageUtils.message(loginType.getRetryLimitExceed(), maxRetryCount, lockTime));
                throw new UserException(loginType.getRetryLimitExceed(), maxRetryCount, lockTime);
            } else {
                // 未达到规定错误次数 则递增
                RedisUtils.setCacheObject(errorKey, errorNumber);//把新的错误次数写回 Redis
                recordLogininfor(tenantId, username, loginFail, MessageUtils.message(loginType.getRetryLimitCount(), errorNumber));//写入日志
                throw new UserException(loginType.getRetryLimitCount(), errorNumber);//抛出异常
            }
        }

        // 登录成功 清空错误次数
        RedisUtils.deleteObject(errorKey);
    }

    private void checkTenant(String tenantId) {
        if (!TenantHelper.isEnable()) {
            return;
        }
        if (TenantConstants.DEFAULT_TENANT_ID.equals(tenantId)) {
            return;
        }
        SysTenantVo tenant = tenantService.queryByTenantId(tenantId);
        if (ObjectUtil.isNull(tenant)) {
            log.info("登录租户：{} 不存在.", tenantId);
            throw new TenantException("tenant.not.exists");
        } else if (TenantStatus.DISABLE.getCode().equals(tenant.getStatus())) {
            log.info("登录租户：{} 已被停用.", tenantId);
            throw new TenantException("tenant.blocked");
        } else if (ObjectUtil.isNotNull(tenant.getExpireTime()) && new Date().after(tenant.getExpireTime())) {
            log.info("登录租户：{} 已超过有效期.", tenantId);
            throw new TenantException("tenant.expired");
        }
    }

}
