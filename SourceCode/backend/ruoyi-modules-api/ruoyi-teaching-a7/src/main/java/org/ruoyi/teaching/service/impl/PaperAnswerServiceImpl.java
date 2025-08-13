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
import org.ruoyi.teaching.domain.PaperAnswer;
import org.ruoyi.teaching.domain.bo.PaperAnswerBo;
import org.ruoyi.teaching.domain.vo.PaperAnswerVo;
import org.ruoyi.teaching.mapper.PaperAnswerMapper;
import org.ruoyi.teaching.service.IPaperAnswerService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * 试卷答案Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class PaperAnswerServiceImpl extends ServiceImpl<PaperAnswerMapper, PaperAnswer> implements IPaperAnswerService {

    private final PaperAnswerMapper baseMapper;

    /**
     * 查询试卷答案
     */
    @Override
    public PaperAnswerVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询试卷答案列表
     */
    @Override
    public TableDataInfo<PaperAnswerVo> queryPageList(PaperAnswerBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<PaperAnswer> lqw = buildQueryWrapper(bo);
        Page<PaperAnswerVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询试卷答案列表
     */
    @Override
    public List<PaperAnswerVo> queryList(PaperAnswerBo bo) {
        LambdaQueryWrapper<PaperAnswer> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<PaperAnswer> buildQueryWrapper(PaperAnswerBo bo) {
        LambdaQueryWrapper<PaperAnswer> lqw = Wrappers.lambdaQuery();
        lqw.eq(Objects.nonNull(bo.getPaperId()), PaperAnswer::getPaperId, bo.getPaperId());
        lqw.eq(Objects.nonNull(bo.getTopicId()), PaperAnswer::getTopicId, bo.getTopicId());
        lqw.eq(Objects.nonNull(bo.getRightAnswer()), PaperAnswer::getRightAnswer, bo.getRightAnswer());
        return lqw;
    }

    /**
     * 新增试卷答案
     */
    @Override
    public Boolean insertByBo(PaperAnswerBo bo) {
        PaperAnswer add = MapstructUtils.convert(bo, PaperAnswer.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改试卷答案
     */
    @Override
    public Boolean updateByBo(PaperAnswerBo bo) {
        PaperAnswer update = MapstructUtils.convert(bo, PaperAnswer.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(PaperAnswer entity) {
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除试卷答案
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 根据试卷ID和题目ID查询答案
     */
    @Override
    public PaperAnswerVo queryByPaperIdAndTopicId(Long paperId, Long topicId) {
        LambdaQueryWrapper<PaperAnswer> lqw = Wrappers.lambdaQuery();
        lqw.eq(PaperAnswer::getPaperId, paperId);
        lqw.eq(PaperAnswer::getTopicId, topicId);
        return baseMapper.selectVoOne(lqw);
    }

    /**
     * 根据试卷ID查询所有答案
     */
    @Override
    public List<PaperAnswerVo> queryByPaperId(Long paperId) {
        LambdaQueryWrapper<PaperAnswer> lqw = Wrappers.lambdaQuery();
        lqw.eq(PaperAnswer::getPaperId, paperId);
        lqw.eq(PaperAnswer::getUserId, LoginHelper.getUserId());
        return baseMapper.selectVoList(lqw);
    }
}