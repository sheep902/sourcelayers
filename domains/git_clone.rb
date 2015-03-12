module GitClone
  include Command

  def runners
    in_e(:downloader).out_v(Project)
  end

end