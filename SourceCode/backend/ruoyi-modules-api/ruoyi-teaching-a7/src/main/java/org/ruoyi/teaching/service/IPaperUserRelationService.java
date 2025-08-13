package org.ruoyi.teaching.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.PaperUserRelation;
import org.ruoyi.teaching.domain.bo.PaperUserRelationBo;
import org.ruoyi.teaching.domain.vo.PaperUserRelationVo;

import java.util.Collection;
import java.util.List;

/**
 * 试卷用户关系Service接口
 *
 * @author baoyu
 */
public interface IPaperUserRelationService extends IService<PaperUserRelation> {

    /**
     * 查询试卷用户关系
     */
    PaperUserRelationVo queryById(Long id);

    /**
     * 查询试卷用户关系列表
     */
    TableDataInfo<PaperUserRelationVo> queryPageList(PaperUserRelationBo bo, PageQuery pageQuery);

    /**
     * 查询试卷用户关系列表
     */
    List<PaperUserRelationVo> queryList(PaperUserRelationBo bo);

    List<PaperUserRelationVo> queryListByIds(List<Long> paperIds);

    /**
     * 新增试卷用户关系
     */
    Boolean insertByBo(PaperUserRelationBo bo);

    /**
     * 修改试卷用户关系
     */
    Boolean updateByBo(PaperUserRelationBo bo);

    /**
     * 校验并批量删除试卷用户关系信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}