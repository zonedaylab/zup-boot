package cn.zup.rbac.entity;

import java.util.List;

public class OrganSubNode {
    /**
     * 组织ID
     */
    private Long organId;
    /**
     * 封装子组织的list
     */
    private List<OrganSubNode> children ;

    public Long getOrganId() {
        return organId;
    }

    public void setOrganId(Long organId) {
        this.organId = organId;
    }

    public List<OrganSubNode> getChildren() {
        return children;
    }

    public void setChildren(List<OrganSubNode> children) {
        this.children = children;
    }
}
