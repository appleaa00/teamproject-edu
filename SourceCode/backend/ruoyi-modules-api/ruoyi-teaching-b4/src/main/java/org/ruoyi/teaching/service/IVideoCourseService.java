package org.ruoyi.teaching.service;


import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.VideoCourse;
import org.ruoyi.teaching.domain.bo.VideoCourseBo;
import org.ruoyi.teaching.domain.vo.VideoCourseVo;

import java.util.Collection;
import java.util.List;

/**
 * Service接口
 *
 * @author baoyu
 */
public interface IVideoCourseService extends IService<VideoCourse> {

    /**
     * 查询课程视频附件
     */
    VideoCourseVo queryById(Long id);

    /**
     * 查询课程视频附件列表
     */
    TableDataInfo<VideoCourseVo> queryPageList(VideoCourseBo bo, PageQuery pageQuery);

    /**
     * 查询课程视频附件列表
     */
    List<VideoCourseVo> queryList(VideoCourseBo bo);

    /**
     * 新增课程视频附件
     */
    Boolean insertByBo(VideoCourseBo bo);

    /**
     * 修改课程视频附件
     */
    Boolean updateByBo(VideoCourseBo bo);

    /**
     * 校验并批量删除课程视频附件信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 删除课程视频
     */
    public void removeEntity(Long id);
}
