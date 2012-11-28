$(function() {
  $('#artist').autocomplete({
    minLength: 2,
    focus: function() { return false; },
      source: function( request, response ) {
      SC.get('/users', { q: request}, function(artists) {
      
          for(artist in artists) {
          artists[artist].value = artists[artist].full_name;
          }
      
      response( $.map( artists, function( item ) {
      return { 
            label: item.full_name + " Tracks: "+ item.track_count,
            value: item.full_name,
            id: item.id
          }
        }));
      });
    },

    select: function(event, ui) {
        SC.get('/users/' + ui.item.id + '/tracks', function(tracks) {
        var select = '';
        for(t in tracks) {
          select += '<option value="' + tracks[t].permalink_url + '">' + tracks[t].title + ' - ' + tracks[t].genre + '</option>';
        } 
        $('#track').html(select);
      });
    }
  });
});