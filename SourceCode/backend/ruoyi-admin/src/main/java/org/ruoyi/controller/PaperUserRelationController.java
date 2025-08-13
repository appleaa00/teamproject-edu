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
import org.ruoyi.teaching.domain.bo.PaperUserRelationBo;
import org.ruoyi.teaching.domain.vo.PaperUserRelationVo;
import org.ruoyi.teaching.service.IPaperUserRelationService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

/**
 * 试卷用户关系管理
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/a7/paperUserRelation")
public class PaperUserRelationController extends BaseController {

    private final IPaperUserRelationService paperUserRelationService;

    /**
     * 获取试卷用户关系列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<PaperUserRelationVo> list(PaperUserRelationBo queryBo, PageQuery pageQuery) {
        return paperUserRelationService.queryPageList(queryBo, pageQuery);
    }

    /**
     * 新增试卷用户关系
     */
    @Log(title = "A7试卷用户关系管理", businessType = BusinessType.INSERT)
    @PostMapping
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody PaperUserRelationBo bo) {
        return toAjax(paperUserRelationService.insertByBo(bo));
    }

    /**
     * 修改试卷用户关系
     */
    @Log(title = "A7试卷用户关系管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody PaperUserRelationBo bo) {
        return toAjax(paperUserRelationService.updateByBo(bo));
    }

    /**
     * 获取试卷用户关系详细信息
     *
     * @param id 主键
     */
    @GetMapping(value = {"/", "/{id}"})
    @SaIgnore
    public R<PaperUserRelationVo> getInfo(@PathVariable(value = "id", required = false) Long id) {
        PaperUserRelationVo paperUserRelationVo = new PaperUserRelationVo();
        if (Objects.nonNull(id)) {
            paperUserRelationVo = paperUserRelationService.queryById(id);
        }
        return R.ok(paperUserRelationVo);
    }

    /**
     * 删除试卷用户关系
     */
    @Log(title = "A7试卷用户关系管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return toAjax(paperUserRelationService.removeById(id));
    }

    /**
     * 批量删除试卷用户关系
     */
    @Log(title = "A7试卷用户关系管理", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @SaIgnore
    public R<Void> remove(@RequestBody Long[] ids) {
        return toAjax(paperUserRelationService.deleteWithValidByIds(java.util.Arrays.asList(ids), true));
    }

    /**
     * 完成考试
     *
     * @param id 主键
     * @param finishTime 完成时间（分钟）
     */
    @PostMapping("/finish/{id}")
    @SaIgnore
    public R<Void> finishExam(@NotNull(message = "主键不能为空") @PathVariable Long id, 
                              @RequestParam Integer finishTime) {
        PaperUserRelationBo bo = new PaperUserRelationBo();
        bo.setId(id);
        bo.setFinished(true);
        bo.setFinishTime(finishTime);
        return toAjax(paperUserRelationService.updateByBo(bo));
    }
}