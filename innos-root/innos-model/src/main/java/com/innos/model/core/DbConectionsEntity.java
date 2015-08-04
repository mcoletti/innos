package com.innos.model.core;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/2/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
public class DbConectionsEntity {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String connStr;

    public String getConnStr() {
        return connStr;
    }

    public void setConnStr(String connStr) {
        this.connStr = connStr;
    }

    private String user;

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DbConectionsEntity that = (DbConectionsEntity) o;

        if (id != that.id) return false;
        if (connStr != null ? !connStr.equals(that.connStr) : that.connStr != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (user != null ? !user.equals(that.user) : that.user != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (connStr != null ? connStr.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        return result;
    }
}
