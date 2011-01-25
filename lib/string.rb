class String
  
  # sentence-based summary with character limit
  def smart_summary(options = {})
    options[:sentences] ||= 2
    options[:letters] ||= 140
    
    sentences = self.split(".").compact[0...options[:sentences]].map{ |sentence| sentence = sentence.rstrip; sentence += ". " if sentence.length > 0 }
    while(sentences.join("").length > options[:letters] && sentences.length > 1) do
      sentences.pop
    end
    
    sentences[0] = sentences[0].truncate(options[:letters])
    sentences.join("")
  end
  
  # converts text to markdown
  # accepts an option of 'strip' which will strip out unwanted tags such as images or links
  def md(options = {})
    options[:strip] ||= []
    RDiscount.new(self).to_html.html_safe
  end
end