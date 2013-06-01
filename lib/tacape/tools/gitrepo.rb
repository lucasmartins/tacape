#coding: utf-8
module Tacape
  module Tools
    class GitRepo < Thor
      include Tacape::Tools::Helpers::JsonConfig
      include Tacape::Tools::Helpers::OsSupport
      namespace 'gitrepo'

      def initialize(*args)
        super
        @os_support=[Tacape::Os::Fedora,Tacape::Os::Osx]
        check_os_support
        @config_file="#{@current_os.config_folder}/gitrepo.json"
        @config_template={
          'default_remote_repo_dir'=>"repos",
          'remote_host_address'=>String.new,
          'remote_host_shortname'=>String.new,
          'username'=>ENV['USER'],
          'ssh_key'=>"#{ENV['HOME']}/.ssh/id_rsa.pub",
          'local_workspace_folder'=>"#{ENV['HOME']}/Workspace"
          }
        
      end

      def load_info
        load_config

        @repos_dir=@config['default_remote_repos_dir']
        @host=@config['remote_host_address']
        @host_shortname=@config['remote_host_shortname']
        @ssh_key = @config['ssh_key']
        @username = @config['username']
        @ssh_hostpath = "#{@username}@#{@host}"
        @ssh_repospath = "#{ssh_hostpath}:#{@repos_dir}"
      end

      desc 'bless',I18n.t('tools.gitrepo.bless.desc')
      def bless(remote_repo_name=nil)
        remote_repo_name = File.basename(Dir.getwd) if remote_repo_name==nil
        load_info
        @ssh_fullpath = "#{ssh_repospath}/#{remote_repo_name}.git"

        unless File.exists? '.git'
          `git init`
        end

        `git remote add #{@host_shortname} #{@ssh_fullpath}`
        puts I18n.t('tools.gitrepo.bless.creating_remote_msg')
        `ssh #{@ssh_hostpath} "mkdir -p #{@repos_dir} && cd #{@repos_dir} && mkdir #{remote_repo_name}.git && cd #{remote_repo_name}.git && git init --bare" && git push #{@host_shortname} --all`
       
      end

      desc 'list', I18n.t('tools.gitrepo.list.desc')
      def list
        load_info
        `ssh #{@ssh_hostpath} "ls --format single-column #{@repo_dir}"`
      end

    end
  end

  #Redefining the Cli to use this Tool
  class Cli < Thor
    desc 'gitrepo','Tacape Tool for managing remote Git repositories through SSH'
    subcommand 'gitrepo', Tools::GitRepo
  end
end