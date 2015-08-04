package com.innos.model.core;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
public class UsersEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    private boolean enabled;

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    private int creUserId;

    public int getCreUserId() {
        return creUserId;
    }

    public void setCreUserId(int creUserId) {
        this.creUserId = creUserId;
    }

    private Date creDtm;

    public Date getCreDtm() {
        return creDtm;
    }

    public void setCreDtm(Date creDtm) {
        this.creDtm = creDtm;
    }

    public UsersEntity() {
    }

    /**
     *
     * @param id
     * @param userName
     * @param enabled
     * @param creUserId
     * @param creDtm
     */
    public UsersEntity(int id, String userName, boolean enabled, int creUserId, Date creDtm) {
        setId(id);
        setUserName(userName);
        setEnabled(enabled);
        setCreUserId(creUserId);
        setCreDtm(creDtm);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UsersEntity that = (UsersEntity) o;

        if (creUserId != that.creUserId) return false;
        if (enabled != that.enabled) return false;
        if (id != that.id) return false;
        if (creDtm != null ? !creDtm.equals(that.creDtm) : that.creDtm != null) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (enabled ? 1 : 0);
        result = 31 * result + creUserId;
        result = 31 * result + (creDtm != null ? creDtm.hashCode() : 0);
        return result;
    }
}
