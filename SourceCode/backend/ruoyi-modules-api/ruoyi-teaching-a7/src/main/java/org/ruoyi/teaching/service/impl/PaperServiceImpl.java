package org.ruoyi.teaching.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.dto.RoleDTO;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.Paper;
import org.ruoyi.teaching.domain.bo.PaperBo;
import org.ruoyi.teaching.domain.bo.TopicBo;
import org.ruoyi.teaching.domain.vo.PaperVo;
import org.ruoyi.teaching.mapper.PaperMapper;
import org.ruoyi.teaching.service.IPaperService;
import org.ruoyi.teaching.service.ITopicService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 试卷Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class PaperServiceImpl extends ServiceImpl<PaperMapper, Paper> implements IPaperService {

    private final PaperMapper baseMapper;
    private final ITopicService topicService;

    /**
     * 查询试卷
     */
    @Override
    public PaperVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询试卷列表
     */
    @Override
    public TableDataInfo<PaperVo> queryPageList(PaperBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<Paper> lqw = buildQueryWrapper(bo);
        List<RoleDTO> roles = LoginHelper.getLoginUser().getRoles();
        if (roles.stream().map(RoleDTO::getRoleKey).toList().contains("teacher")) {  // 教师只需要查自己提交
            lqw.eq(Paper::getCreateBy, LoginHelper.getUserId());
        }
        if (roles.stream().map(RoleDTO::getRoleKey).toList().contains("student")) {  // 学生需要查自己提交和老师提交的
            lqw.and((e) -> e.eq(Paper::getCreateBy, LoginHelper.getUserId()).or((e1) -> e1.eq(Paper::getCreateRole, "teacher")));
        }
        Page<PaperVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询试卷列表
     */
    @Override
    public List<PaperVo> queryList(PaperBo bo) {
        LambdaQueryWrapper<Paper> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<Paper> buildQueryWrapper(PaperBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<Paper> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getPaperName()), Paper::getPaperName, bo.getPaperName());
        lqw.eq(StringUtils.isNotBlank(bo.getPaperDifficulty()), Paper::getPaperDifficulty, bo.getPaperDifficulty());
        lqw.eq(StringUtils.isNotBlank(bo.getPaperType()), Paper::getPaperType, bo.getPaperType());
        lqw.eq(StringUtils.isNotBlank(bo.getCreateName()), Paper::getCreateName, bo.getCreateName());
        lqw.eq(Objects.nonNull(bo.getTopicNumber()), Paper::getTopicNumber, bo.getTopicNumber());
        lqw.eq(Objects.nonNull(bo.getAnswerTime()), Paper::getAnswerTime, bo.getAnswerTime());
        lqw.eq(Objects.nonNull(bo.getCollection()), Paper::getCollection, bo.getCollection());
        lqw.gt(Objects.nonNull(bo.getStartCreateTime()), Paper::getCreateTime, bo.getStartCreateTime());
        lqw.lt(Objects.nonNull(bo.getEndCreateTime()), Paper::getCreateTime, bo.getEndCreateTime());
        return lqw;
    }

    /**
     * 新增试卷
     */
    @Override
    public Boolean insertByBo(PaperBo bo) {

        Paper add = MapstructUtils.convert(bo, Paper.class);//将 PaperBo 转换为 Paper 实体 控制层与数据层解耦
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            List<TopicBo> topics = bo.getTopics();
            topics.forEach(topicBo -> {
                topicBo.setPaperId(add.getId());//自增ID；每道题都设置试卷 ID，建立题目与试卷的关联关系（外键）
                topicService.insertByBo(topicBo);
            });
        }
        return flag;
    }

    /**
     * 修改试卷
     */
    @Override
    public Boolean updateByBo(PaperBo bo) {
        Paper update = MapstructUtils.convert(bo, Paper.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(Paper entity) {
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除试卷
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
            // 校验逻辑，如判断是否允许删除、是否关联答题记录等
//            for (Long id : ids) {
//                Paper paper = baseMapper.selectById(id);
//                if (Boolean.TRUE.equals(paper.getCollection())) {
//                    throw new ServiceException("已收藏的试卷不能删除！");
//                }
//            }
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 删除试卷信息
     */
    @Override
    public Boolean removeEntity(Long id) {
        return baseMapper.deleteById(id) > 0;
    }
}