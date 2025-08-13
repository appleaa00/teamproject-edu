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
import org.ruoyi.teaching.domain.Topic;
import org.ruoyi.teaching.domain.bo.TopicBo;
import org.ruoyi.teaching.domain.vo.TopicVo;
import org.ruoyi.teaching.service.ITopicService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

/**
 * 题目管理
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/a7/topic")
public class TopicController extends BaseController {

    private final ITopicService topicService;


    /**
     * 获取题目列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<TopicVo> list(TopicBo queryBo, PageQuery pageQuery) {
        return topicService.queryPageList(queryBo, pageQuery);
    }

    /**
     * 新增题目
     */
    @Log(title = "A7题目管理", businessType = BusinessType.INSERT)
    @PostMapping
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody TopicBo bo) {
        topicService.insertByBo(bo);
        return R.ok();
    }

    /**
     * 修改题目
     */
    @Log(title = "A7题目管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@RequestBody TopicBo bo) {
        return toAjax(topicService.updateByBo(bo));
    }

    /**
     * 获取题目详细信息
     *
     * @param id 主键
     */
    @GetMapping(value = {"/", "/{id}"})
    @SaIgnore
    public R<TopicVo> getInfo(@PathVariable(value = "id", required = false) Long id) {

        TopicVo topicVo = new TopicVo();
        if (Objects.nonNull(id)) {
            topicVo = topicService.queryById(id);
        }
        return R.ok(topicVo);
    }

    /**
     * 收藏题目
     *
     * @param id 主键
     */
    @GetMapping("/collection/{id}")
    @SaIgnore
    public R<Boolean> collection(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        Topic topic = topicService.getById(id);
        topic.setCollection(!Convert.toBool(topic.getCollection(), false));
        topicService.updateById(topic);
        return R.ok(topic.getCollection());
    }

    /**
     * 删除题目
     */
    @DeleteMapping("/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        topicService.removeEntity(id);
        return R.ok();
    }

    /**
     * 批量删除题目
     */
    @PostMapping("/remove")
    @SaIgnore
    public R<Void> remove(@RequestBody Long[] ids) {
        topicService.deleteWithValidByIds(java.util.Arrays.asList(ids), true);
        return R.ok();
    }
}