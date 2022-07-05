import React from "react";
import Button from "./Button";
import PropTypes from "prop-types";

const Header = ({ title }) => {

    const onClick = () => {
        console.log("onClick");
    }

    return (
        <header className="header">
            <h1>{title}</h1>
            <Button onClick={onClick} />
        </header>
    )
}

Header.defaultProps = {
    title: "Task Header",
}

Header.propTypes = {
    title: PropTypes.string.isRequired
}




export default Header;