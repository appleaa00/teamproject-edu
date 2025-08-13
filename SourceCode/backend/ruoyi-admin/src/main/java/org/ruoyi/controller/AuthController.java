package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import cn.hutool.core.collection.CollUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.constant.Constants;
import org.ruoyi.common.core.domain.R; //R是统一返回结果类
import org.ruoyi.common.core.domain.model.*;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.utils.StreamUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.tenant.helper.TenantHelper;
import org.ruoyi.system.domain.bo.SysTenantBo;
import org.ruoyi.system.domain.vo.LoginTenantVo;
import org.ruoyi.system.domain.vo.LoginVo;
import org.ruoyi.system.domain.vo.SysTenantVo;
import org.ruoyi.system.domain.vo.TenantListVo;
import org.ruoyi.system.service.ISysTenantService;
import org.ruoyi.system.service.SysLoginService;
import org.ruoyi.system.service.SysRegisterService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.net.URL;
import java.util.List;

/**
 * 认证
 *
 * @author Lion Li
 */
@SaIgnore
@Validated
@RequiredArgsConstructor //自动创建对象
@RestController
@RequestMapping("/auth") //这个控制器下的所有接口，地址都以 /auth 开头
public class AuthController {

    private final SysLoginService loginService;
    private final SysRegisterService registerService;
    private final ISysTenantService tenantService;

    /**
     * 登录方法
     *
     * @param body 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public R<LoginVo> login(@Validated @RequestBody LoginBody body) { //R<LoginVo>是返回值类型，返回一个包装后的登录结果对象，body 是前端传来的登录参数，包括用户名、密码、验证码等
        body.setTenantId(Constants.TENANT_ID); //给 body 对象设置一个租户 ID
        LoginVo loginVo = new LoginVo(); //创建一个新的对象 loginVo，用来存放登录结果
        // 生成令牌
        String token = loginService.login(
                body.getTenantId(),
                body.getUsername(), body.getPassword(),
                body.getCode(), body.getUuid());
        loginVo.setToken(token);
        // 兼容后台管理登录
        loginVo.setAccess_token(token);
        loginVo.setUserInfo(LoginHelper.getLoginUser());//把 token 和用户信息封装成一个结果对象
        return R.ok(loginVo);
    }

    /**
     * 短信登录
     *
     * @param body 登录信息
     * @return 结果
     */
    @PostMapping("/smsLogin")
    public R<LoginVo> smsLogin(@Validated @RequestBody SmsLoginBody body) {
        LoginVo loginVo = new LoginVo();
        // 生成令牌
        String token = loginService.smsLogin(body.getTenantId(), body.getPhonenumber(), body.getSmsCode());
        loginVo.setToken(token);//把返回的 token 封装进返回对象中
        return R.ok(loginVo);//用统一包装类 R 返回结果
    }

    /**
     * 访客登录
     * @param loginBody 登录信息
     * @return token信息
     */
    @PostMapping("/visitorLogin")//前端想用这个接口，只需发POST请求到http://yourhost/api/auth/visitorLogin
    public R<LoginVo> visitorLogin(@RequestBody VisitorLoginBody loginBody) {

        //TODO “访客登录”的核心逻辑尚未写

        LoginVo loginVo = new LoginVo();
        return R.ok(loginVo);
    }

    /**
     * 邮件登录
     *
     * @param body 登录信息
     * @return 结果
     */
    @PostMapping("/emailLogin")
    public R<LoginVo> emailLogin(@Validated @RequestBody EmailLoginBody body) {
        LoginVo loginVo = new LoginVo();
        // 生成令牌
        String token = loginService.emailLogin(body.getTenantId(), body.getEmail(), body.getEmailCode());
        loginVo.setToken(token);
        return R.ok(loginVo);//统一使用 R<T> 包装返回结果，便于前后端联调
    }

    /**
     * 退出登录
     */
    @PostMapping("/logout")
    public R<Void> logout() {
        loginService.logout();
        return R.ok("退出成功");
    }

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public R<Void> register(@Validated @RequestBody RegisterBody user, HttpServletRequest request) {
        String domainName =  request.getServerName();//获取请求的域名
        user.setDomainName(domainName);//将域名写入 RegisterBody
        registerService.register(user);
        return R.ok();
    }

    /**
     * 重置密码
     */
    @PostMapping("/reset/password")
    @SaIgnore//表示这个接口不需要登录即可访问
    public R<Void> resetPassWord(@Validated @RequestBody RegisterBody user) {
        registerService.resetPassWord(user);
        return R.ok();
    }

    /**
     * 登录页面租户下拉框
     *
     * @return 租户列表
     */
    @GetMapping("/tenant/list")
    public R<LoginTenantVo> tenantList(HttpServletRequest request) throws Exception {
        List<SysTenantVo> tenantList = tenantService.queryList(new SysTenantBo());//从数据库查询所有符合条件的租户
        List<TenantListVo> voList = MapstructUtils.convert(tenantList, TenantListVo.class);//把数据库查出来的 SysTenantVo 转换成只包含租户名称、租户编码、域名等前端需要的字段（TenantListVo）
        // 获取域名
        String host = new URL(request.getRequestURL().toString()).getHost();//用户可能通过“域名”访问不同租户，因此需要识别出当前域名对应的租户。
        // 根据域名进行筛选
        List<TenantListVo> list = StreamUtils.filter(voList, vo -> StringUtils.equals(vo.getDomain(), host));//从所有租户里筛选出“域名和当前请求域名一致”的租户
        // 返回对象
        LoginTenantVo vo = new LoginTenantVo();
        vo.setVoList(CollUtil.isNotEmpty(list) ? list : voList);
        vo.setTenantEnabled(TenantHelper.isEnable());
        return R.ok(vo);
    }

}
