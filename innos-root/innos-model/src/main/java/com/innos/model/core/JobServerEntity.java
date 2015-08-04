package com.innos.model.core;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
public class JobServerEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String host;

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    private boolean active;

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    private String ipAddress;

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        JobServerEntity that = (JobServerEntity) o;

        if (active != that.active) return false;
        if (id != that.id) return false;
        if (host != null ? !host.equals(that.host) : that.host != null) return false;
        if (ipAddress != null ? !ipAddress.equals(that.ipAddress) : that.ipAddress != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (host != null ? host.hashCode() : 0);
        result = 31 * result + (active ? 1 : 0);
        result = 31 * result + (ipAddress != null ? ipAddress.hashCode() : 0);
        return result;
    }
}
