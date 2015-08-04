package com.innos.model.core;

import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
public class EtlJobQueueEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private Timestamp runDtm;

    public Timestamp getRunDtm() {
        return runDtm;
    }

    public void setRunDtm(Timestamp runDtm) {
        this.runDtm = runDtm;
    }

    private Timestamp endDtm;

    public Timestamp getEndDtm() {
        return endDtm;
    }

    public void setEndDtm(Timestamp endDtm) {
        this.endDtm = endDtm;
    }

    private boolean running;

    public boolean isRunning() {
        return running;
    }

    public void setRunning(boolean running) {
        this.running = running;
    }

    private boolean assigned;

    public boolean isAssigned() {
        return assigned;
    }

    public void setAssigned(boolean assigned) {
        this.assigned = assigned;
    }

    private boolean complete;

    public boolean isComplete() {
        return complete;
    }

    public void setComplete(boolean complete) {
        this.complete = complete;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EtlJobQueueEntity that = (EtlJobQueueEntity) o;

        if (assigned != that.assigned) return false;
        if (complete != that.complete) return false;
        if (id != that.id) return false;
        if (running != that.running) return false;
        if (endDtm != null ? !endDtm.equals(that.endDtm) : that.endDtm != null) return false;
        if (runDtm != null ? !runDtm.equals(that.runDtm) : that.runDtm != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (runDtm != null ? runDtm.hashCode() : 0);
        result = 31 * result + (endDtm != null ? endDtm.hashCode() : 0);
        result = 31 * result + (running ? 1 : 0);
        result = 31 * result + (assigned ? 1 : 0);
        result = 31 * result + (complete ? 1 : 0);
        return result;
    }
}
