require 'pdfkit'
class PDFKit
  class Configuration
    def wkhtmltopdf
      @wkhtmltopdf ||= `which wkhtmltopdf`.chomp
    end
  end
end