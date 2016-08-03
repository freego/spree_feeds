module SpreeFeeds
  class Cvetta < SpreeFeeds::Base

    def perform
      tags = SpreeFeeds::Config.cvetta_tags
      file_path = "#{@base_path}/cvetta.xml"
      file = File.new("#{file_path}.tmp", "w")

      xml = Builder::XmlMarkup.new(target: file)
      # xml.instruct! :xml, version: "1.0"
      xml.add do
        @products.each do |product|
          variants = product.variants.many? ? product.variants : [product.master]
          variants.each do |variant|
            helper = Helpers::Cvetta.new(variant, @root_url)
            xml.doc do
              tags.each do |t|
                if t == 'categories'
                  product.taxons.each do |root|
                    root.self_and_descendants.each do |taxon|
                      xml.tag!(:field, name: t) { xml.cdata!(taxon.name) }
                    end
                  end
                else
                  if helper.respond_to?(t) && value = helper.send(t)
                    xml.tag!(:field, name: t) { xml.cdata!(strip_tags(value.to_s)) }
                  end
                end
              end
            end
          end
        end
      end

      file.close
      File.rename("#{file_path}.tmp", file_path)
      file_path
    end

  end
end
