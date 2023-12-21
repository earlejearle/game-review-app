import React, {useEffect, useState} from 'react';
import game from "./Game";

function FaveButton ({id, game_id}) {
    const [faves, setFaves] = useState([])

 
    useEffect(() => {
       fetch(`/users/${id}/favourite_games`)
        .then(r => r.json())
        .then(json => setFaves(json)) 
    }, [id])

    let fave = faves.find((fav) => game_id === fav.game_id)
    

    function addFave (event) {
        const faveData = {game_id}
        fetch(`/users/${id}/favourite_games`, {
            method: "POST",
            headers: {
                "Content-Type":"application/json"
            },
            mode: "cors",
            body: JSON.stringify(faveData),
            params: {
                game_id: game_id
            }
            
        }) 
        .then(r => {
            r.json().then(data => {
                setFaves([data])
            })
        })

    }

    function deleteFave() {
        fetch(`/users/${id}/favourite_games/${fave.id}`, {
            method: "DELETE"
        })
        .then(r => {
            setFaves([])
        })
    }

    // if (fave === true) {
    //   return (
    //     <p>This has been favourited!</p>
    // )  
    // } else {

    if (fave) {
      return (
        <button className="red-heart" onClick={deleteFave}> ❤️ </button>
        )    
    } else {
        return (
            <button className="clear-heart" onClick={addFave}> 🤍 </button>
        )
    }
      
    // }

    
    // 🤍 ❤️

}

export default FaveButton;