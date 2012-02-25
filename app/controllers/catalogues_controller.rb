class CataloguesController < ApplicationController
  # GET /catalogues
  def index
    @catalogues = Catalogue.all
    @catalogue = Catalogue.new
    respond_to do |format|
      format.html # index.html.erb
      format.pdf {
        html = render_to_string(:layout => false , :action => "show.html.erb")
        kit = PDFKit.new(html, :page_size=>'A4',:margin_top    => '11.5mm',
        :margin_right  => '17.5mm',
        :margin_bottom => '5.8mm',
        :margin_left   => '17.5mm')
        kit.stylesheets << "#{Rails.root}/public/stylesheets/screen.css"
        send_data(kit.to_pdf, :filename => "labels.pdf", :type => 'application/pdf')
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
        html = render_to_string(:layout => false , :action => "show.html.haml")
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
        format.html { redirect_to @catalogue, :notice => 'Catalogue was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /catalogues/1
  # PUT /catalogues/1.json
  def update
    @catalogue = Catalogue.find(params[:id])

    respond_to do |format|
      if @catalogue.update_attributes(params[:catalogue])
        format.html { redirect_to @catalogue, :notice=> 'Catalogue was successfully updated.' }

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
