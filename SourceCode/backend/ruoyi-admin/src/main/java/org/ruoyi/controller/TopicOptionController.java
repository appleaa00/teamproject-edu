package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.bo.TopicOptionBo;
import org.ruoyi.teaching.domain.vo.TopicOptionVo;
import org.ruoyi.teaching.service.ITopicOptionService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 题目选项管理
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/topicOption")
public class TopicOptionController extends BaseController {

    private final ITopicOptionService topicOptionService;

    /**
     * 获取题目选项列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<TopicOptionVo> list(TopicOptionBo queryBo, PageQuery pageQuery) {
        return topicOptionService.queryPageList(queryBo, pageQuery);
    }

    /**
     * 新增题目选项
     */
    @Log(title = "A7题目选项管理", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody TopicOptionBo bo) {
        topicOptionService.insertByBo(bo);
        return R.ok();
    }

    /**
     * 修改题目选项
     */
    @Log(title = "A7题目选项管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@RequestBody TopicOptionBo bo) {
        return toAjax(topicOptionService.updateByBo(bo));
    }

    /**
     * 获取题目选项详细信息
     *
     * @param id 主键
     */
    @GetMapping("/info/{id}")
    @SaIgnore
    public R<TopicOptionVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(topicOptionService.queryById(id));
    }

    /**
     * 删除题目选项
     */
    @PostMapping("/remove/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        topicOptionService.removeEntity(id);
        return R.ok();
    }

    /**
     * 批量删除题目选项
     */
    @PostMapping("/remove")
    @SaIgnore
    public R<Void> remove(@RequestBody Long[] ids) {
        topicOptionService.deleteWithValidByIds(java.util.Arrays.asList(ids), true);
        return R.ok();
    }
}