module Project
  include PacerRecord
  links :parser, :downloader
  props :name, :remote

  def parser
  end

  def downloader
    out_e(:downloader).in_v(GitClone)
  end

  def self.create(params)
    p = super(params)
    c = GitClone.create
    p.connect to: c, through: :downloader
    p
  end
end