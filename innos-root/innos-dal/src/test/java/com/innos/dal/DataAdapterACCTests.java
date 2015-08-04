package com.innos.dal;

import com.innos.model.core.UsersEntity;
import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 3/3/13
 * Time: 5:04 PM
 * To change this template use File | Settings | File Templates.
 */
@Test(groups = {"acc"})
public class DataAdapterACCTests {

    private IDataAdapter dataAdapter;


    @BeforeClass
    public void init(){

        ApplicationContext appContext =
                new ClassPathXmlApplicationContext("spring-config.xml");

        dataAdapter = (IDataAdapter) appContext.getBean("dataAdapter");





    }

    @Test
    public void testCreateUser() throws Exception {

        UsersEntity user = new UsersEntity();
        user.setUserName("mcoletti");
        user.setEnabled(true);
        user.setCreDtm(new Date());


        boolean actual = dataAdapter.addOrUpdateUser(user);
        Assert.assertTrue(actual);

    }
}
