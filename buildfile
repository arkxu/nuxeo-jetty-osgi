
#require "buildr4osgi"

require "build/dependencies.rb"
require "build/repositories.rb"

# Generated by Buildr 1.3.4, change to your liking
# Version number for this release
VERSION_NUMBER = "5.3.1-SNAPSHOT"
# Group identifier for your projects
GROUP = "nuxeo-jetty-osgi"

layout = Layout.new
layout[:source, :main, :java] = 'src'

desc "The Nuxeo-jetty-osgi project"
define "nuxeo-jetty-osgi", :layout => layout do

  project.version = VERSION_NUMBER
  project.group = GROUP
  compile.options.source = "1.5"
  compile.options.target = "1.5"

  define "org.nuxeo.logging" do
    package(:jar).with :manifest=>_('META-INF/MANIFEST.MF')
  end
  
  define "org.nuxeo.ecm.directory.api" do
    compile.with NUXEO_ECM_CORE[:api], NUXEO_COMMON, NUXEO_RUNTIME, APACHE[:commons_logging]
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
    end
  end

  define "org.nuxeo.ecm.directory.core" do
    compile.with project("org.nuxeo.ecm.directory.api"), NUXEO_ECM_CORE[:api], NUXEO_RUNTIME, NUXEO_COMMON, APACHE[:commons_logging], NUXEO_ECM_CORE[:schema]
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
    end    
  end
  
  define "org.nuxeo.ecm.directory.sql" do
    compile.with project("org.nuxeo.ecm.directory.api"), project("org.nuxeo.ecm.directory.core"), NUXEO_ECM_CORE[:api], HIBERNATE, APACHE[:commons_logging], NUXEO_RUNTIME, NUXEO_ECM_CORE[:schema], NUXEO_COMMON, APACHE[:common_lang], APACHE[:common_codec], OPEN_CSV
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
      file.include _("user2group.csv")
      file.include _("users.csv")
      file.include _("groups.csv")
      file.include _("rl_role_user.csv")
      file.include _("upgrade-reference-tables.sql")
    end
  end
  
  define "org.nuxeo.ecm.directory.types.contrib" do
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
      file.include _("directoryschema"), "directoryschema/*"
    end
  end
  
  define "org.nuxeo.ecm.platform.usermanager" do
    compile.with project("org.nuxeo.ecm.platform.usermanager.api"), project("org.nuxeo.ecm.directory.api"), NUXEO_ECM_CORE[:api], APACHE[:commons_logging], NUXEO_RUNTIME, NUXEO_COMMON
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
    end
  end

  define "org.nuxeo.ecm.platform.usermanager.api" do
    compile.with project("org.nuxeo.logging"), NUXEO_ECM_CORE[:api], COMMON[:collections], APACHE[:commons_logging], NUXEO_RUNTIME, NUXEO_COMMON
    package(:jar).with(:manifest=>_('META-INF/MANIFEST.MF')).enhance do |file|
      file.include _("OSGI-INF"), "OSGI-INF/*"
    end
  end

end
