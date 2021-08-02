module Links
    class Generator < Jekyll::Generator
        def generate(site)
            # For each note
            site.collections['notes'].docs.each do |pagesrc|
                # Get the wikilinks
                links = pagesrc.content.scan(/\[\[(.+)\]\]/)
                for link in links
                    # For each wikilink, find the destination note
                    site.collections['notes'].docs.each do |pagedest|
                        # Add the source note as back link to the destination note
                        if pagedest.id.gsub('/notes/', '') == (link[0])
                            pagesrc.content = pagesrc.content.gsub('[[' + link[0] + ']]', '[' + pagedest.title + '](/notes/' + link[0] + ')')
                            pagedest.backlinks.push(pagesrc.id.gsub('/notes/', ''))
                        end
                    end
                 end
              end
        end
    end
end