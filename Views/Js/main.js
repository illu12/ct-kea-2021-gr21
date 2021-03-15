


$(document).ready(()=>{
  localStorage.clear();

  $(".answer").click(function(){

    // Save answer weight in localStorage {key:weight}
    localStorage.setItem($(this).parent().parent().attr("id").match(/\d+$/)[0],$(this).attr("data-weight"));

    // If last question has been answered.
    if($(this).parent().parent().attr("id").match(/\d+$/)[0]==$("#quizLength").val()){
      // Send http, expect redirect in return ..

      // Set customer_id
      localStorage.setItem("customer_id",$("#customer_id").val());

      let options = {
        method: "POST",
        headers: {
          "Content-type": "application/json"
        },
        body: JSON.stringify(localStorage)
      };

      console.log(options);

      fetch("http://localhost/submit",options)
      .then((res)=>{
        return res.text();
      })
      .then((data)=>{
        console.log(data);
      });

    }
    // Else, show next question div
    else{
      // Save id for reference
      let id = parseInt($(this).parent().parent().attr("id").match(/\d+$/)[0]);
      console.log(id);
      // Remove current question div
      $(`#question${id}`).animate({
        opacity: 0,
        "z-index": 0
      },1000);

    //  $(`#${id.slice(0,id.length-1)+1}`).animate({opacity:1},1000);
      $(`#question${id+1}`).animate({
        opacity: 1,
        display: "block"
      },2000).show();

    }


  });

});
