package com.innos.model.core;

import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
public class EtlJobEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String jobName;

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    private Timestamp creDtm;

    public Timestamp getCreDtm() {
        return creDtm;
    }

    public void setCreDtm(Timestamp creDtm) {
        this.creDtm = creDtm;
    }

    private boolean enabled;

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EtlJobEntity that = (EtlJobEntity) o;

        if (enabled != that.enabled) return false;
        if (id != that.id) return false;
        if (creDtm != null ? !creDtm.equals(that.creDtm) : that.creDtm != null) return false;
        if (jobName != null ? !jobName.equals(that.jobName) : that.jobName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (jobName != null ? jobName.hashCode() : 0);
        result = 31 * result + (creDtm != null ? creDtm.hashCode() : 0);
        result = 31 * result + (enabled ? 1 : 0);
        return result;
    }
}
