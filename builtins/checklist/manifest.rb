listing_file = options['listing'] || "manifest.#{ options['cas'] }.yml"
listing      = local(listing_file)

create "transformations.#{ options['cas'] }.yml" do |trans|

  listing.split("\n").each do |line|
    if line =~ /^\[(.)\]\s+(.+)$/
      if $1 == 'X'
        filename = $2.tr(' ', '').underscore + ".yml"
        
        trans.file filename
      end
    else
      trans.text line
    end
  end

end