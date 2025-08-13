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
import org.ruoyi.teaching.domain.VideoCourse;
import org.ruoyi.teaching.domain.bo.VideoCourseBo;
import org.ruoyi.teaching.domain.vo.VideoCourseVo;
import org.ruoyi.teaching.mapper.VideoCourseMapper;
import org.ruoyi.teaching.service.IVideoCourseService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Service业务层处理
 *
 * @author baoyu
 */
@RequiredArgsConstructor
@Service
public class VideoCourseServiceImpl extends ServiceImpl<VideoCourseMapper, VideoCourse> implements IVideoCourseService {

    private final VideoCourseMapper baseMapper;


    /**
     * 查询知识库附件
     */
    @Override
    public VideoCourseVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 查询知识库附件列表
     */
    @Override
    public TableDataInfo<VideoCourseVo> queryPageList(VideoCourseBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<VideoCourse> lqw = buildQueryWrapper(bo);
        Page<VideoCourseVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询知识库附件列表
     */
    @Override
    public List<VideoCourseVo> queryList(VideoCourseBo bo) {
        LambdaQueryWrapper<VideoCourse> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<VideoCourse> buildQueryWrapper(VideoCourseBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<VideoCourse> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getVideoName()), VideoCourse::getVideoName, bo.getVideoName());
        lqw.eq(Objects.nonNull(bo.getCollection()), VideoCourse::getCollection, bo.getCollection());
        lqw.gt(Objects.nonNull(bo.getStartCreateTime()), VideoCourse::getCreateTime, bo.getStartCreateTime());
        return lqw;
    }

    /**
     * 新增知识库附件
     */
    @Override
    public Boolean insertByBo(VideoCourseBo bo) {
        VideoCourse add = MapstructUtils.convert(bo, VideoCourse.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改知识库附件
     */
    @Override
    public Boolean updateByBo(VideoCourseBo bo) {
        VideoCourse update = MapstructUtils.convert(bo, VideoCourse.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(VideoCourse entity) {
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
