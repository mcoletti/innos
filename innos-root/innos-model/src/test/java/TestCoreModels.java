import com.innos.model.core.DataSource;
import com.innos.model.core.UsersEntity;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.util.Date;

import static org.testng.Assert.assertEquals;

/**
 * Created with IntelliJ IDEA.
 * User: mcoletti
 * Date: 2/28/13
 * Time: 7:31 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestCoreModels {


    private Date creDate;
    private int creUserId;
    private boolean isEnabled;

    @BeforeClass
    public void init(){

        creDate = new Date();
        creUserId = 2;
        isEnabled = true;


    }


    @Test
    public void testUserModel() throws Exception {


        UsersEntity user = new UsersEntity(1,"testUser",true,creUserId,creDate);
        assertEquals(1, user.getId());
        assertEquals("testUser", user.getUserName());
        assertEquals(isEnabled, user.isEnabled());
        assertEquals(creUserId, user.getCreUserId());
        assertEquals(creDate, user.getCreDtm());

    }

    @Test
    public void testDataSource() throws Exception {

        DataSource  dataSource = new DataSource("testUser","password","test","test");
        assertEquals(dataSource.getUseName(),"testUser");
        assertEquals(dataSource.getPassword(),"password");
        assertEquals(dataSource.getDriverClass(),"test");
        assertEquals(dataSource.getDbUrl(),"test");

    }
}
