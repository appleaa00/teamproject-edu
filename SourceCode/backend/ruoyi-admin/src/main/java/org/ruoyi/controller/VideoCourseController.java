package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import cn.hutool.core.convert.Convert;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.VideoCourse;
import org.ruoyi.teaching.domain.bo.VideoCourseBo;
import org.ruoyi.teaching.domain.vo.VideoCourseVo;
import org.ruoyi.teaching.service.IVideoCourseService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 视频解析保存
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/videoCourse")
public class VideoCourseController extends BaseController {

    private final IVideoCourseService videoCourseService;

    /**
     * 获取列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<VideoCourseVo> list(VideoCourseBo queryBo, PageQuery pageQuery) {

        return videoCourseService.queryPageList(queryBo, pageQuery);
    }

    /**
     * 新增
     */
    @Log(title = "B4视频解析", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody VideoCourseBo bo) {
        videoCourseService.insertByBo(bo);
        return R.ok();
    }

    /**
     * 修改
     */
    @Log(title = "B4视频解析", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@RequestBody VideoCourseBo bo) {
        return toAjax(videoCourseService.updateByBo(bo));
    }

    /**
     * 获取知识库附件详细信息
     *
     * @param id 主键
     */
    @GetMapping("attach/info/{id}")
    @SaIgnore
    public R<VideoCourseVo> getAttachInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(videoCourseService.queryById(id));
    }

    /**
     * 收藏视频
     *
     * @param id 主键
     */
    @GetMapping("collection/{id}")
    @SaIgnore
    public R<Boolean> collection(@NotNull(message = "主键不能为空") @PathVariable Long id) {

        VideoCourse videoCourse = videoCourseService.getById(id);
        videoCourse.setCollection(!Convert.toBool(videoCourse.getCollection(), false));
        videoCourseService.updateById(videoCourse);
        return R.ok(videoCourse.getCollection());
    }

    /**
     * 删除
     */
    @PostMapping("remove/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        videoCourseService.removeEntity(id);
        return R.ok();
    }

}
