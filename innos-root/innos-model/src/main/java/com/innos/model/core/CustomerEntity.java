package com.innos.model.core;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 9:13 AM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String uuid;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    private String custName;

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    private String dbConnStr;

    public String getDbConnStr() {
        return dbConnStr;
    }

    public void setDbConnStr(String dbConnStr) {
        this.dbConnStr = dbConnStr;
    }

    private boolean enabled;

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    private int typeId;

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomerEntity that = (CustomerEntity) o;

        if (enabled != that.enabled) return false;
        if (id != that.id) return false;
        if (typeId != that.typeId) return false;
        if (custName != null ? !custName.equals(that.custName) : that.custName != null) return false;
        if (dbConnStr != null ? !dbConnStr.equals(that.dbConnStr) : that.dbConnStr != null) return false;
        if (uuid != null ? !uuid.equals(that.uuid) : that.uuid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (uuid != null ? uuid.hashCode() : 0);
        result = 31 * result + (custName != null ? custName.hashCode() : 0);
        result = 31 * result + (dbConnStr != null ? dbConnStr.hashCode() : 0);
        result = 31 * result + (enabled ? 1 : 0);
        result = 31 * result + typeId;
        return result;
    }
}
