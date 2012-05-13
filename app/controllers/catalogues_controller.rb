class CataloguesController < ApplicationController
  # GET /catalogues
  def index
    @catalogues = Catalogue.order("position")
    @catalogue = Catalogue.new
    respond_to do |format|
      format.html # index.html.erb
      format.pdf {
        html = render_to_string(:layout => false , :action => "pdf.html.erb")
        kit = PDFKit.new(html, :page_size=>'A4',
        :margin_top    => '40mm',
        :margin_right  => '17.5mm',
        :margin_bottom => '10mm',
        :margin_left   => '17.5mm', 
        :header_font_size =>"9",
        :footer_html =>"#{Rails.root}/public/footer.html" ,
        :header_html =>"#{Rails.root}/public/header.html" )
        kit.stylesheets << "#{Rails.root}/public/stylesheets/screen.css"
        send_data(kit.to_pdf, :filename => "catalog_fabrika-art_#{DateTime.now.year}_#{DateTime.now.month}_#{DateTime.now.day}.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
      
    end
  end

  # GET /catalogues/1
  # GET /catalogues/1.json
  def show
    @catalogues = Catalogue.all    
    @catalogue = Catalogue.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {
        html = render_to_string(:layout => false , :action => "pdf.html.haml")
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/screen.css"
        send_data(kit.to_pdf, :filename => "labels.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end

  # GET /catalogues/new
  # GET /catalogues/new.json
  def new
    @catalogue = Catalogue.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /catalogues/1/edit
  def edit
    @catalogue = Catalogue.find(params[:id])
  end

  # POST /catalogues
  # POST /catalogues.json
  def create
    @catalogue = Catalogue.new(params[:catalogue])

    respond_to do |format|
      if @catalogue.save
        format.html { redirect_to catalogues_url, :notice => 'Catalogue was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  def sort
    @catalogues = Catalogue.all
    @catalogues.each do |catalogue|
      catalogue.position = params['table'].index(catalogue.id.to_s) + 1
      catalogue.save
    end
    render :nothing => true
  end
  # PUT /catalogues/1
  # PUT /catalogues/1.json
  def update
    @catalogue = Catalogue.find(params[:id])

    respond_to do |format|
      if @catalogue.update_attributes(params[:catalogue])
        format.html { redirect_to catalogues_url+"#table_#{@catalogue.id}", :notice=> 'Catalogue was successfully updated.' }

      else
        format.html { render :action => "edit" }

      end
    end
  end

  # DELETE /catalogues/1
  # DELETE /catalogues/1.json
  def destroy
    @catalogue = Catalogue.find(params[:id])
    @catalogue.destroy

    respond_to do |format|
      format.html { redirect_to catalogues_url }

    end
  end
end
