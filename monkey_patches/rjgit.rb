RJGit::RubyGit

module RJGit
  class RubyGit
    java_import 'org.eclipse.jgit.lib.EmptyProgressMonitor'

    class ProgressMonitor < EmptyProgressMonitor
      def initialize(&block)
        @block = block
      end
    end

    def self.clone(remote, local, options = {}, &block)
      clone_command = Git.clone_repository
      clone_command.setURI(remote)
      clone_command.set_directory(java.io.File.new(local))
      clone_command.set_bare(true) if options[:is_bare]
      clone_command.set_progress_monitor()
      if options[:branch]
        if options[:branch] == :all
          clone_command.set_clone_all_branches(true)
        else
          clone_command.set_branch(options[:branch])
        end
      end
      if options[:username]
        clone_command.set_credentials_provider(UsernamePasswordCredentialsProvider.new(options[:username], options[:password]))
      end
      clone_command.call
      Repo.new(local)
    end
  end
end

