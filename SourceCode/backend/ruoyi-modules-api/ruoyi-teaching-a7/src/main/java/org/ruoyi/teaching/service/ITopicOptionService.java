package org.ruoyi.teaching.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.TopicOption;
import org.ruoyi.teaching.domain.bo.TopicOptionBo;
import org.ruoyi.teaching.domain.vo.TopicOptionVo;

import java.util.Collection;
import java.util.List;

/**
 * Service接口
 *
 * @author baoyu
 */
public interface ITopicOptionService extends IService<TopicOption> {

    /**
     * 查询题目选项
     */
    TopicOptionVo queryById(Long id);

    /**
     * 查询题目选项列表
     */
    TableDataInfo<TopicOptionVo> queryPageList(TopicOptionBo bo, PageQuery pageQuery);

    /**
     * 查询题目选项列表
     */
    List<TopicOptionVo> queryList(TopicOptionBo bo);
    List<TopicOptionVo> queryByTopicIds(List<Long> topicIds);

    /**
     * 新增题目选项
     */
    Boolean insertByBo(TopicOptionBo bo);

    /**
     * 修改题目选项
     */
    Boolean updateByBo(TopicOptionBo bo);

    /**
     * 校验并批量删除题目选项信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 删除题目选项
     */
    void removeEntity(Long id);
}