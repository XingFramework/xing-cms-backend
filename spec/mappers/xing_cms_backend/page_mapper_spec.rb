require 'spec_helper'

module XingCmsBackend
  describe PageMapper, :type => :mapper do
    describe "saving content" do
      describe "for a page with two content blocks" do
        let :mapper do
          PageMapper.new(json)
        end

        before do
          allow(Page::OneColumn).to receive(:content_format).and_return(format)
        end

        let :format do
          [{ :name         => 'headline',
             :content_type => 'text/html'
          },
          {  :name         => 'main',
             :content_type => 'text/html'
          }]
        end

        let :valid_data do
          { data: {
            title:    'foo bar',
            keywords: 'foo, bar',
            layout: 'one_column',
            contents: {
              main:     { data: { body: "Fourscore and seven years." }},
              headline: { data: { body: "The Gettysburg Address" }}
            }
          }}
        end

        describe "when the passed content matches the specs" do
          let :json do
            valid_data.to_json
          end

          it "should create the page" do
            expect do
              mapper.save
            end.to change{ Page::OneColumn.count}.by(1)
            expect(Page.last.title).to eq 'foo bar'
          end

          it "should return as page" do
            expect(mapper.save).to be_truthy
          end

          it "should create the content blocks" do
            expect do
              mapper.save
            end.to change{ ContentBlock.count}.by(2)
            page = Page.last
            expect(page.contents['main'].body).to     eq('Fourscore and seven years.')
            expect(page.contents['headline'].body).to eq('The Gettysburg Address')
          end

          it "should be able to return the page" do
            mapper.save
            expect(mapper.page).to be_a(Page)
            expect(mapper.page).to be_persisted
          end
        end

        describe "when extra content is provided" do
          let :invalid_data do
            valid_data.deep_merge({ data: { contents: {
              main:     { data: { body: "Fourscore and seven years." }},
              headline: { data: { body: "The Gettysburg Address" }},
              sidebar:  { data: { body: "See below for other famous speeches!" }}
            }}}
            )
          end

          let :json do
            invalid_data.to_json
          end

          # TODO is this supposed to reject the entire page or can we just reject the extra content??
          it "should save the page without the extra content block" do
            expect do
              expect do
                mapper.save
              end.to change{ Page.count }.by(1)
            end.to change{ ContentBlock.count }.by(2)
            expect(Page.last.contents["sidebar"]).to be_nil
          end
        end

        describe "when required content is missing" do
          let :format do
            [{ :name         => 'headline',
               :content_type => 'text/html'
            },
            {  :name         => 'main',
               :content_type => 'text/html',
               :required     => true
            }]
          end

          let :json do
            invalid_data.to_json
          end

          describe "because the value is blank" do
            let :invalid_data do
              valid_data.deep_merge({data: {contents: {
                main: { data: { body: "" } }
              }}})
            end

            it "should insert an error into the errors hash without saving anything" do
              expect do
                expect do
                  mapper.save
                end.not_to change{ Page.count }
              end.not_to change{ ContentBlock.count }
              expect(mapper.errors).to eq(
                {:data=>{:contents=>{"main"=>{:data=>{:body=>{:type=>"required", :message=>"can't be blank"}}}}}}
              )
            end
          end

          describe "because the block is not submitted" do
            let :invalid_data do
              { data: {
                title:    'foo bar',
                keywords: 'foo, bar',
                layout: 'one_column',
                contents: {
                  headline: { data: { body: "The Gettysburg Address" }}
                }
              }}
            end

            it "should insert an error into the errors hash without saving anything" do
              expect do
                expect do
                  mapper.save
                end.not_to change{ Page.count }
              end.not_to change{ ContentBlock.count }
              expect(mapper.errors).to eq(
                {:data=>{:contents=>{"main"=>{:data=>{:type=>"required", :message=>"This block is required: main"}}}}}
              )
            end
          end
        end
      end
    end


    describe "updating" do
      let :page do
        FactoryGirl.create(:one_column_page, :title => 'The Old Title')
      end

      let :mapper do
        PageMapper.new(json, page.url_slug)
      end

      describe "an attribute column" do
        let :json do
          { data: { title: "The New Title" } }.to_json
        end

        it "should update the desired column" do
          expect do
            mapper.save
          end.to change{ page.reload.title }.to("The New Title")
        end

        # is this too clever for its own good?  trying to avoid having to make
        # a new mapper and save it for each individual attribute
        it "should not update anything else" do
          unchanged_fields = [ :url_slug, :keywords, :description, :contents ]
          expect do
            mapper.save
          end.not_to change {
            page.reload
            unchanged_fields.map do |key|
              [ key, page.send(key) ]
            end
          }
        end

        it "should be able to return the page" do
          mapper.save
          expect(mapper.page).to eq(page)
          expect(mapper.page).to be_persisted
        end
      end

      describe "a content body" do
        let :json do
          { data: { contents: { main: { data: { body: "The New Body" }}}}}.to_json
        end

        it "should update the desired column" do
          expect do
            mapper.save
          end.to change{ page.reload.contents['main'].body }.to("The New Body")
        end

        # is this too clever for its own good?  trying to avoid having to make
        # a new mapper and save it for each individual attribute
        it "should not update anything else" do
          unchanged_fields = [ :url_slug, :keywords, :description, :title ]
          expect do
            mapper.save
          end.not_to change {
            page.reload
            unchanged_fields.map do |key|
              [ key, page.send(key) ]
            end
          }
        end
      end

      describe "a content body with layout specified" do
        let :json do
          { data: {
            contents: { main: { data: { body: "The New Body" }}},
            'layout' => 'one_column'
            }
          }.to_json
        end

        it "should update the desired column" do
          expect do
            mapper.save
          end.to change{ page.reload.contents['main'].body }.to("The New Body")
        end

        # is this too clever for its own good?  trying to avoid having to make
        # a new mapper and save it for each individual attribute
        it "should not update anything else" do
          unchanged_fields = [ :url_slug, :keywords, :description, :title ]
          expect do
            mapper.save
          end.not_to change {
            page.reload
            unchanged_fields.map do |key|
              [ key, page.send(key) ]
            end
          }
        end
      end

      describe "a content body with invalid fields" do
        let :json do
          { data: {
            contents: { main: { data: { body: "" }}},
            'layout' => 'one_column'
            }
          }.to_json
        end

        it "should not update the desired column" do
          expect do
            mapper.save
          end.not_to change{ page.reload.contents['main'].body }
        end

        it "should add to errors hash" do
          mapper.save
          expect(mapper.errors[:data]).to eq({:contents=>{"main"=>{:data=>{:body=>{:type=>"required", :message=>"can't be blank"}}}}})
        end

        # is this too clever for its own good?  trying to avoid having to make
        # a new mapper and save it for each individual attribute
        it "should not update anything else" do
          unchanged_fields = [ :url_slug, :keywords, :description, :title ]
          expect do
            mapper.save
          end.not_to change {
            page.reload
            unchanged_fields.map do |key|
              [ key, page.send(key) ]
            end
          }
        end
      end
    end
  end
end
