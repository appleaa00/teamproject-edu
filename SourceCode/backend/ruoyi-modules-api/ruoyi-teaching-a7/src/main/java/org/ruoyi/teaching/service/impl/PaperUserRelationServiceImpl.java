package org.ruoyi.teaching.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.PaperUserRelation;
import org.ruoyi.teaching.domain.bo.PaperAnswerBo;
import org.ruoyi.teaching.domain.bo.PaperUserRelationBo;
import org.ruoyi.teaching.domain.vo.PaperUserRelationVo;
import org.ruoyi.teaching.mapper.PaperUserRelationMapper;
import org.ruoyi.teaching.service.IPaperAnswerService;
import org.ruoyi.teaching.service.IPaperUserRelationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * 试卷用户关系Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class PaperUserRelationServiceImpl extends ServiceImpl<PaperUserRelationMapper, PaperUserRelation> implements IPaperUserRelationService {

    private final PaperUserRelationMapper baseMapper;
    private final IPaperAnswerService paperAnswerService;

    /**
     * 查询试卷用户关系
     */
    @Override
    public PaperUserRelationVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询试卷用户关系列表
     */
    @Override
    public TableDataInfo<PaperUserRelationVo> queryPageList(PaperUserRelationBo bo, PageQuery pageQuery) {

        LambdaQueryWrapper<PaperUserRelation> lqw = buildQueryWrapper(bo);
        Page<PaperUserRelationVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询试卷用户关系列表
     */
    @Override
    public List<PaperUserRelationVo> queryList(PaperUserRelationBo bo) {
        LambdaQueryWrapper<PaperUserRelation> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    @Override
    public List<PaperUserRelationVo> queryListByIds(List<Long> paperIds) {

        LambdaQueryWrapper<PaperUserRelation> lqw = Wrappers.lambdaQuery();
        lqw.in(PaperUserRelation::getPaperId, paperIds);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<PaperUserRelation> buildQueryWrapper(PaperUserRelationBo bo) {
        LambdaQueryWrapper<PaperUserRelation> lqw = Wrappers.lambdaQuery();
        lqw.eq(Objects.nonNull(bo.getPaperId()), PaperUserRelation::getPaperId, bo.getPaperId());
        lqw.eq(Objects.nonNull(bo.getUserId()), PaperUserRelation::getUserId, bo.getUserId());
        lqw.eq(Objects.nonNull(bo.getFinished()), PaperUserRelation::getFinished, bo.getFinished());
        lqw.eq(Objects.nonNull(bo.getFinishTime()), PaperUserRelation::getFinishTime, bo.getFinishTime());
        return lqw;
    }

    /**
     * 新增试卷用户关系
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(PaperUserRelationBo bo) {
        PaperUserRelation add = MapstructUtils.convert(bo, PaperUserRelation.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            List<PaperAnswerBo> paperAnswerBoList = bo.getPaperAnswerBoList();
            if (!CollectionUtils.isEmpty(paperAnswerBoList)) {
                paperAnswerBoList.forEach(answerBo -> answerBo.setPaperId(bo.getPaperId()));
                paperAnswerBoList.forEach(answerBo -> answerBo.setUserId(LoginHelper.getUserId()));
                paperAnswerBoList.forEach(paperAnswerService::insertByBo);
            }
        }
        return flag;
    }

    /**
     * 修改试卷用户关系
     */
    @Override
    public Boolean updateByBo(PaperUserRelationBo bo) {
        PaperUserRelation update = MapstructUtils.convert(bo, PaperUserRelation.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(PaperUserRelation entity) {
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除试卷用户关系
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }
}