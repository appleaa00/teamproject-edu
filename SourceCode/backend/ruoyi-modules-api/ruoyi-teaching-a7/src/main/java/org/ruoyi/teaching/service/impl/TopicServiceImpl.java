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
import org.ruoyi.teaching.domain.Topic;
import org.ruoyi.teaching.domain.bo.TopicBo;
import org.ruoyi.teaching.domain.bo.TopicOptionBo;
import org.ruoyi.teaching.domain.vo.TopicOptionVo;
import org.ruoyi.teaching.domain.vo.TopicVo;
import org.ruoyi.teaching.mapper.TopicMapper;
import org.ruoyi.teaching.service.ITopicOptionService;
import org.ruoyi.teaching.service.ITopicService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class TopicServiceImpl extends ServiceImpl<TopicMapper, Topic> implements ITopicService {

    private final TopicMapper baseMapper;

    private final ITopicOptionService topicOptionService;

    /**
     * 查询题目
     */
    @Override
    public TopicVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询题目列表
     */
    @Override
    public TableDataInfo<TopicVo> queryPageList(TopicBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<Topic> lqw = buildQueryWrapper(bo);
        Page<TopicVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询题目列表
     */
    @Override
    public List<TopicVo> queryList(TopicBo bo) {
        LambdaQueryWrapper<Topic> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    @Override
    public List<TopicVo> queryByPaperId(Long paperId) {
        LambdaQueryWrapper<Topic> lqw = Wrappers.lambdaQuery();
        lqw.eq(Topic::getPaperId, paperId);//查询指定试卷
        List<TopicVo> topicVos = baseMapper.selectVoList(lqw);//将 Topic 实体转为 TopicVo
        List<Long> topicIds = topicVos.stream().filter(topicVo -> topicVo.getTopicType().equals("选择题")).map(TopicVo::getId).toList();
        if (!CollectionUtils.isEmpty(topicIds)) {
            List<TopicOptionVo> topicOptionVos = topicOptionService.queryByTopicIds(topicIds);
            Map<Long, List<TopicOptionVo>> topicOptionMap = topicOptionVos.stream().collect(Collectors.groupingBy(TopicOptionVo::getTopicId));//按 topicId 分组
            topicVos.forEach(topicVo -> topicVo.setTopicOptions(topicOptionMap.get(topicVo.getId())));//将选项集合放回每个 TopicVo 对象中
        }
        return topicVos;
    }

    private LambdaQueryWrapper<Topic> buildQueryWrapper(TopicBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<Topic> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getTopicName()), Topic::getTopicName, bo.getTopicName());
        lqw.eq(StringUtils.isNotBlank(bo.getTopicDifficulty()), Topic::getTopicDifficulty, bo.getTopicDifficulty());
        lqw.eq(Objects.nonNull(bo.getTopicType()), Topic::getTopicType, bo.getTopicType());
        lqw.eq(Objects.nonNull(bo.getCollection()), Topic::getCollection, bo.getCollection());
        lqw.gt(Objects.nonNull(bo.getStartCreateTime()), Topic::getCreateTime, bo.getStartCreateTime());
        return lqw;
    }

    /**
     * 新增题目
     */
    @Override
    public Boolean insertByBo(TopicBo bo) {
        Topic add = MapstructUtils.convert(bo, Topic.class);//把 TopicBo 转换成 Topic，控制层传过来的是 Bo，数据库只接受 Entity，统一数据结构。
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
            List<TopicOptionBo> topicOptions = bo.getTopicOptions();//获取题目的选项列表
            if (!CollectionUtils.isEmpty(topicOptions)) {
                topicOptions.forEach(topicOption -> {
                    topicOption.setTopicId(add.getId());// 外键绑定
                    topicOptionService.insertByBo(topicOption);// 保存每个选项
                });

            }
        }
        return flag;
    }

    /**
     * 修改题目
     */
    @Override
    public Boolean updateByBo(TopicBo bo) {
        Topic update = MapstructUtils.convert(bo, Topic.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(Topic entity) {
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