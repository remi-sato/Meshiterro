window.initMap = async function () {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  const map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
    mapId: "DEMO_MAP_ID"
  });

  try {
    const response = await fetch("/post_images.json");
    const {data:{items}} = await response.json();

    items.forEach((item) => {
  const userImage = item.user.image;
  const userName = item.user.name;
  const postImage = item.image;

  const marker = new AdvancedMarkerElement({
    position: {
      lat: item.latitude,
      lng: item.longitude
    },
    map: map,
    title: item.shop_name
  });

      const contentString = `
       <div>
        <img src="${userImage}" width="40" height="40">
        <p>${userName}</p>
        <img src="${postImage}" width="200">

        <h3>${item.shop_name}</h3>
        <p>${item.address}</p>
        <p>${item.caption}</p>
       </div>
       `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString
      });

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map
        });
      });
    });
  } catch(error) {
    console.error(error);
  }
};