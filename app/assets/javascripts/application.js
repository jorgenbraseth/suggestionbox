// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
    $(".voteLink").click(function(e){
        e.preventDefault();
        voteLink = $(this);

        if(voteLink.hasClass("enabled")){
            voteLink.removeClass("enabled");
            url = voteLink.attr("href");
            $.ajax(url, {type: "POST", dataType: "json"})
                .success(function(data){
                    console.log(data);
                    suggestion = $("#suggestion_"+data.id);
                    suggestion.find(".count").html(data.suggestion_votes_count);
                });
        }
    });

    $("#suggestion_description").keyup(function(){
        if($(this).val().trim()){
            $(".editActions input").addClass("enabled");
        }else{
            $(".editActions input").removeClass("enabled");
        }
    })

    $(".graphicButton").on("click",function(e){
        if(!$(this).hasClass("enabled")){
            e.preventDefault();
        }
    });

    $("#newCategoryName").keypress(function(e){
        if(e.charCode == 13){
            categoryName = $(this).val();
            rootPath = $(this).data("category-path");
            window.location = rootPath + "box/" + categoryName;
        }
    })
});
