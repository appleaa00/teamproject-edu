package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import cn.hutool.core.convert.Convert;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.domain.dto.RoleDTO;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.vo.SysUserVo;
import org.ruoyi.system.service.ISysUserService;
import org.ruoyi.teaching.domain.Paper;
import org.ruoyi.teaching.domain.bo.PaperAnswerBo;
import org.ruoyi.teaching.domain.bo.PaperBo;
import org.ruoyi.teaching.domain.bo.PaperUserRelationBo;
import org.ruoyi.teaching.domain.vo.PaperAnswerVo;
import org.ruoyi.teaching.domain.vo.PaperUserRelationVo;
import org.ruoyi.teaching.domain.vo.PaperVo;
import org.ruoyi.teaching.domain.vo.TopicVo;
import org.ruoyi.teaching.service.IPaperAnswerService;
import org.ruoyi.teaching.service.IPaperService;
import org.ruoyi.teaching.service.IPaperUserRelationService;
import org.ruoyi.teaching.service.ITopicService;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 试卷管理
 *
 * @author baoyu
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/a7/paper")
public class PaperController extends BaseController {

    private final IPaperService paperService;
    private final ITopicService topicService;
    private final ISysUserService userService;
    private final IPaperUserRelationService paperUserRelationService;
    private final IPaperAnswerService paperAnswerService;

    /**
     * 获取试卷列表
     */
    @GetMapping("/list")
    @SaIgnore
    public TableDataInfo<PaperVo> list(PaperBo queryBo, PageQuery pageQuery) {

        TableDataInfo<PaperVo> pager = paperService.queryPageList(queryBo, pageQuery);
        List<PaperVo> rows = pager.getRows();
        if (!CollectionUtils.isEmpty(rows)) {
            List<Long> paperIds = MapstructUtils.convertList(rows, PaperVo::getId);
            List<PaperUserRelationVo> relationVos = paperUserRelationService.queryListByIds(paperIds);
            Map<Long, Boolean> relationMap = relationVos.stream().collect(Collectors.toMap(PaperUserRelationVo::getPaperId, PaperUserRelationVo::getFinished));
            rows.forEach(v -> v.setFinished(relationMap.getOrDefault(v.getId(), false)));
        }
        return pager;
    }

    /**
     * 新增试卷
     */
    @Log(title = "A7试卷管理", businessType = BusinessType.INSERT)
    @PostMapping
    @SaIgnore
    public R<Void> save(@Validated(AddGroup.class) @RequestBody PaperBo bo) {
        SysUserVo sysUserVo = userService.selectUserById(LoginHelper.getUserId());
        List<RoleDTO> roles = LoginHelper.getLoginUser().getRoles();
        bo.setCreateRole(roles.stream().map(RoleDTO::getRoleKey).toList().contains("teacher") ? "teacher" : "student");
        bo.setCreateName(sysUserVo.getNickName());
        bo.setTopicNumber(bo.getTopics().size());
        paperService.insertByBo(bo);
        return R.ok();
    }



    /**
     * 修改试卷
     */
    @Log(title = "A7试卷管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @SaIgnore
    public R<Void> edit(@RequestBody PaperBo bo) {
        return toAjax(paperService.updateByBo(bo));
    }

    /**
     * 保存答案
     */
    @Log(title = "A7试卷管理", businessType = BusinessType.UPDATE)
    @PostMapping("/saveAnswer/{paperId}")
    @SaIgnore
    public R<Void> saveAnswer(@PathVariable Long paperId, @RequestBody List<PaperAnswerBo> boList) {

        Long userId = LoginHelper.getUserId();
        PaperUserRelationBo relationBo = new PaperUserRelationBo();
        relationBo.setUserId(userId);
        relationBo.setFinished(true);
        relationBo.setPaperId(paperId);
        relationBo.setPaperAnswerBoList(boList);
        Boolean flag = paperUserRelationService.insertByBo(relationBo);
        return toAjax(flag);
    }

    /**
     * 获取试卷详细信息
     *
     * @param id 主键
     */
    @GetMapping(value = {"/", "/{id}"})
    @SaIgnore
    public R<PaperVo> getInfo(@PathVariable(value = "id", required = false) Long id) {//id是可选参数
        PaperVo paperVo = new PaperVo();
        if (Objects.nonNull(id)) {
            paperVo = paperService.queryById(id);
            // 设置是否完成答题
            List<PaperUserRelationVo> relationVos = paperUserRelationService.queryListByIds(List.of(id));
            paperVo.setFinished(!CollectionUtils.isEmpty(relationVos));
            // 设置题目列表
            List<TopicVo> topicVos = topicService.queryByPaperId(paperVo.getId());
            paperVo.setTopics(topicVos);
            // 为提示列表设置当前用户回答的答案
            if (paperVo.getFinished()) {  // 完成后才会获取答案
                List<PaperAnswerVo> paperAnswerVos = paperAnswerService.queryByPaperId(paperVo.getId());
                Map<Long, PaperAnswerVo> answerVoMap = paperAnswerVos.stream().collect(Collectors.toMap(PaperAnswerVo::getTopicId, Function.identity()));
                topicVos.forEach(topicVo -> {
                    PaperAnswerVo answerVo = answerVoMap.get(topicVo.getId());
                    Optional.ofNullable(answerVo).ifPresent(vo -> topicVo.setTopicWrite(vo.getTopicWrite()));
                    Optional.ofNullable(answerVo).ifPresent(vo -> topicVo.setRightAnswer(vo.getRightAnswer()));
                });
            }
        }
        return R.ok(paperVo);
    }

    /**
     * 收藏试卷
     *
     * @param id 主键
     */
    @GetMapping("/collection/{id}")
    @SaIgnore
    public R<Boolean> collection(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        Paper paper = paperService.getById(id);
        paper.setCollection(!Convert.toBool(paper.getCollection(), false));
        paperService.updateById(paper);
        return R.ok(paper.getCollection());
    }

    /**
     * 删除试卷
     */
    @DeleteMapping("/{id}")
    @SaIgnore
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        paperService.removeEntity(id);
        return R.ok();
    }

    /**
     * 批量删除试卷
     */
    @PostMapping("/remove")
    @SaIgnore
    public R<Void> remove(@RequestBody Long[] ids) {
        paperService.deleteWithValidByIds(java.util.Arrays.asList(ids), true);
        return R.ok();
    }
}