function doLike(postId, userId){

    const data = {
        postId: postId,
        userId: userId,
        operation: "like"
    }

    $.ajax({
        url: "like-post",
        data: data,
        success: function (data, textStatus, jqXRH) {
            console.log(data)
        },
        error: function (jqXRH, textStatus, errorThrown) {
            console.log(jqXRH)
        }
    })
}