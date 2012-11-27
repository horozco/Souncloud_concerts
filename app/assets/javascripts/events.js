$(function() {
  $('#artist').autocomplete({
    
    focus: function() { return false; },
      source: function( request, response ) {
      SC.get('/users', { q: request}, function(artists) {
      
          for(artist in artists) {
          artists[artist].value = artists[artist].full_name;
          }
      
      response( $.map( artists, function( item ) {
      return { 
            value: item.full_name + " Tracks: "+ item.track_count
          }
        }));
      });
    },
    minLength: 2,
});
});