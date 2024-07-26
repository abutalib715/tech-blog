function doLike(postId, ref) {

    const data = {
        postId: postId,
        operation: "like"
    }

    $.ajax({
        url: "like-post",
        data: data,
        success: function (data, textStatus, jqXHR) {
            if (data.trim() === 'true') {
                let likeCounter = $(ref).find(".like-counter");
                let currentCount = parseInt(likeCounter.html());
                likeCounter.html(currentCount + 1);
            }
        },
        error: function (jqXRH, textStatus, errorThrown) {
            console.log(jqXRH)
        }
    })
}