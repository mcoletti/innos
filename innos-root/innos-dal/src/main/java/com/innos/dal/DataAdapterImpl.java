package com.innos.dal;

import com.innos.model.core.UsersEntity;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.sql.Connection;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 2/28/13
 * Time: 5:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class DataAdapterImpl extends HibernateDaoSupport implements IDataAdapter {


    /**
     * Add or Update a User
     * @param user
     * @return
     */
    @Override
    public boolean addOrUpdateUser(UsersEntity user) {
        try {
            getHibernateTemplate().saveOrUpdate(user);
            return true;
        } catch (DataAccessException e) {
            return false;
        }
    }

    @Override
    public UsersEntity getUser(int i) {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
