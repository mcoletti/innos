package com.innos.dal;

import com.innos.model.core.UsersEntity;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 2/28/13
 * Time: 6:05 PM
 * To change this template use File | Settings | File Templates.
 */
public interface IDataAdapter {
    boolean addOrUpdateUser(UsersEntity user);

    UsersEntity getUser(int i);
}
