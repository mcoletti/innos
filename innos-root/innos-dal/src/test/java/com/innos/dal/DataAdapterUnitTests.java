package com.innos.dal;

import com.innos.model.core.UsersEntity;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.sql.Connection;
import java.util.Date;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertNotNull;
import static org.testng.Assert.assertTrue;


/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 2/28/13
 * Time: 5:58 PM
 * To change this template use File | Settings | File Templates.
 */
@Test(groups = {"unit"})
public class DataAdapterUnitTests {

    private IDataAdapter dataAdapterMock;
    private Connection connectionMock;
    private UsersEntity user;


    @BeforeClass
    public void init() {

        dataAdapterMock = mock(IDataAdapter.class);
        connectionMock = mock(Connection.class);
        user = new UsersEntity(1, "testUser", true, 0, new Date());
        when(dataAdapterMock.getUser(1)).thenReturn(user);
    }


    @Test
    public void testInitDataAdapter() throws Exception {
        assertNotNull(dataAdapterMock, "The DataAdapterImpl was not initialized correctly");
    }

    @Test(enabled = false)
    public void testCreateUser() throws Exception {




        boolean actual = dataAdapterMock.addOrUpdateUser(user);
       assertTrue(actual);
       dataAdapterMock.getUser(1);
    }

    @Test
    public void testGetUser() throws Exception {


        UsersEntity actual = dataAdapterMock.getUser(1);
        assertTrue(actual.equals(user));


    }
}
