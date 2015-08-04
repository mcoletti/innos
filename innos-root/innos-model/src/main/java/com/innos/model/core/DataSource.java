package com.innos.model.core;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/5/13
 * Time: 4:43 AM
 * To change this template use File | Settings | File Templates.
 */
public class DataSource {

    private String useName;
    private String password;
    private String dbUrl;
    private String driverClass;

    /**
     *
     * @param useName
     * @param password
     * @param dbUrl
     * @param driverClass
     */
    public DataSource(String useName, String password, String dbUrl, String driverClass) {
        setUseName(useName);
        setPassword(password);
        setDbUrl(dbUrl);
        setDriverClass(driverClass);
    }

    public String getUseName() {
        return useName;
    }

    public void setUseName(String useName) {
        this.useName = useName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDbUrl() {
        return dbUrl;
    }

    public void setDbUrl(String dbUrl) {
        this.dbUrl = dbUrl;
    }

    public String getDriverClass() {
        return driverClass;
    }

    public void setDriverClass(String driverClass) {
        this.driverClass = driverClass;
    }
}
