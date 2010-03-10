package osgitest;

import org.nuxeo.ecm.core.api.NuxeoPrincipal;
import org.nuxeo.ecm.platform.usermanager.UserManager;
import org.nuxeo.ecm.platform.usermanager.UserService;
import org.nuxeo.runtime.api.Framework;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class Activator implements BundleActivator {

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext
	 * )
	 */
	public void start(BundleContext context) throws Exception {
		System.out.println("startMessage");

		UserService us = (UserService) Framework.getRuntime().getComponent(
				UserService.NAME);
		UserManager um = us.getUserManager();
		boolean login = um.checkUsernamePassword("Administrator", "Administrator");
		System.out.println(login);
		boolean login2 = um.checkUsernamePassword("Administrator2", "Administrator2");
		System.out.println(login2);
		boolean login3 = um.checkUsernamePassword("admin", "123");
		System.out.println(login3);
		NuxeoPrincipal np = um.getPrincipal("admin");
		System.out.println(np);

		
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	public void stop(BundleContext context) throws Exception {
		System.out.println("stopMessage");
	}

}
