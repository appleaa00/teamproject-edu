package org.ruoyi.teaching.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.Paper;
import org.ruoyi.teaching.domain.bo.PaperBo;
import org.ruoyi.teaching.domain.vo.PaperVo;

import java.util.Collection;
import java.util.List;

/**
 * 试卷Service接口
 *
 * @author baoyu
 */
public interface IPaperService extends IService<Paper> {

    /**
     * 查询试卷
     */
    PaperVo queryById(Long id);

    /**
     * 查询试卷列表
     */
    TableDataInfo<PaperVo> queryPageList(PaperBo bo, PageQuery pageQuery);

    /**
     * 查询试卷列表
     */
    List<PaperVo> queryList(PaperBo bo);

    /**
     * 新增试卷
     */
    Boolean insertByBo(PaperBo bo);

    /**
     * 修改试卷
     */
    Boolean updateByBo(PaperBo bo);

    /**
     * 校验并批量删除试卷信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 删除试卷信息
     */
    Boolean removeEntity(Long id);
}