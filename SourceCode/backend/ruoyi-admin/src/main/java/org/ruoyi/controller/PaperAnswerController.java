package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.bo.PaperAnswerBo;
import org.ruoyi.teaching.domain.vo.PaperAnswerVo;
import org.ruoyi.teaching.service.IPaperAnswerService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

/**
 * 试卷答案管理
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/a7/paperAnswer")
public class PaperAnswerController extends BaseController {

    private final IPaperAnswerService paperAnswerService;

    /**
     * 获取试卷答案列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<PaperAnswerVo> list(PaperAnswerBo queryBo, PageQuery pageQuery) {
        return paperAnswerService.queryPageList(queryBo, pageQuery);
    }

    /**
     * 新增试卷答案
     */
    @Log(title = "A7试卷答案管理", businessType = BusinessType.INSERT)
    @PostMapping
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody PaperAnswerBo bo) {
        return toAjax(paperAnswerService.insertByBo(bo));
    }

    /**
     * 修改试卷答案
     */
    @Log(title = "A7试卷答案管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody PaperAnswerBo bo) {
        return toAjax(paperAnswerService.updateByBo(bo));
    }

    /**
     * 获取试卷答案详细信息
     *
     * @param id 主键
     */
    @GetMapping(value = {"/", "/{id}"})
    @SaIgnore
    public R<PaperAnswerVo> getInfo(@PathVariable(value = "id", required = false) Long id) {
        PaperAnswerVo paperAnswerVo = new PaperAnswerVo();
        if (Objects.nonNull(id)) {
            paperAnswerVo = paperAnswerService.queryById(id);
        }
        return R.ok(paperAnswerVo);
    }

    /**
     * 删除试卷答案
     */
    @Log(title = "A7试卷答案管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return toAjax(paperAnswerService.removeById(id));
    }

    /**
     * 批量删除试卷答案
     */
    @Log(title = "A7试卷答案管理", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @SaIgnore
    public R<Void> remove(@RequestBody Long[] ids) {
        return toAjax(paperAnswerService.deleteWithValidByIds(java.util.Arrays.asList(ids), true));
    }

    /**
     * 根据试卷ID和题目ID查询答案
     */
    @GetMapping("/query/{paperId}/{topicId}")
    @SaIgnore
    public R<PaperAnswerVo> queryByPaperIdAndTopicId(@PathVariable Long paperId, @PathVariable Long topicId) {
        PaperAnswerVo paperAnswerVo = paperAnswerService.queryByPaperIdAndTopicId(paperId, topicId);
        return R.ok(paperAnswerVo);
    }

    /**
     * 根据试卷ID查询所有答案
     */
    @GetMapping("/paper/{paperId}")
    @SaIgnore
    public R<List<PaperAnswerVo>> queryByPaperId(@PathVariable Long paperId) {
        List<PaperAnswerVo> list = paperAnswerService.queryByPaperId(paperId);
        return R.ok(list);
    }
}