import React from 'react'
import PropTypes from "prop-types";

const Button = ({ color, text, onClick }) => {
    return (
        <button
            className="btn"
            style={{ backgroundColor: color }}
            onClick={onClick}
        >
            {text}
        </button>
    )
}

Button.defaultProps = {
    color: "green",
    text: "Add"
}

Button.propTypes = {
    color: PropTypes.string.isRequired,
    text: PropTypes.string.isRequired,
    onClick: PropTypes.func.isRequired
}

export default Button