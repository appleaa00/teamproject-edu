package org.ruoyi.teaching.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.TopicOption;
import org.ruoyi.teaching.domain.bo.TopicOptionBo;
import org.ruoyi.teaching.domain.vo.TopicOptionVo;
import org.ruoyi.teaching.mapper.TopicOptionMapper;
import org.ruoyi.teaching.service.ITopicOptionService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class TopicOptionServiceImpl extends ServiceImpl<TopicOptionMapper, TopicOption> implements ITopicOptionService {

    private final TopicOptionMapper baseMapper;

    /**
     * 查询题目选项
     */
    @Override
    public TopicOptionVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询题目选项列表
     */
    @Override
    public TableDataInfo<TopicOptionVo> queryPageList(TopicOptionBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<TopicOption> lqw = buildQueryWrapper(bo);
        Page<TopicOptionVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询题目选项列表
     */
    @Override
    public List<TopicOptionVo> queryList(TopicOptionBo bo) {
        LambdaQueryWrapper<TopicOption> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    @Override
    public List<TopicOptionVo> queryByTopicIds(List<Long> topicIds) {
        LambdaQueryWrapper<TopicOption> lqw = Wrappers.lambdaQuery();
        lqw.in(TopicOption::getTopicId, topicIds);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<TopicOption> buildQueryWrapper(TopicOptionBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<TopicOption> lqw = Wrappers.lambdaQuery();
        lqw.eq(StringUtils.isNotBlank(bo.getSorted()), TopicOption::getSorted, bo.getSorted());
        lqw.like(StringUtils.isNotBlank(bo.getOptionContent()), TopicOption::getOptionContent, bo.getOptionContent());
        return lqw;
    }

    /**
     * 新增题目选项
     */
    @Override
    public Boolean insertByBo(TopicOptionBo bo) {
        TopicOption add = MapstructUtils.convert(bo, TopicOption.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改题目选项
     */
    @Override
    public Boolean updateByBo(TopicOptionBo bo) {
        TopicOption update = MapstructUtils.convert(bo, TopicOption.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(TopicOption entity) {
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    @Override
    public void removeEntity(Long id) {
        baseMapper.deleteById(id);
    }
}