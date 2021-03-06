import React, {Component} from 'react';
import PropTypes from 'prop-types';
import ClayIcon from '../shared/ClayIcon.es';
import {DragSource as dragSource} from 'react-dnd';
import {DragTypes} from '../../utils/drag-types.es';
import getCN from 'classnames';

/**
 * Passes the required values to the drop target.
 * This method must be called `beginDrag`.
 * @param {Object} props Component's current props
 * @returns {Object} The props to be passed to the drop target.
 */
function beginDrag({name, defaultValue}) {
	return {
		criterion: {
			defaultValue,
			propertyName: name
		}
	};
}

class CriteriaSidebarItem extends Component {
	static propTypes = {
		className: PropTypes.string,
		connectDragSource: PropTypes.func,
		defaultValue: PropTypes.string,
		dragging: PropTypes.bool,
		label: PropTypes.string,
		name: PropTypes.string,
		type: PropTypes.string
	};

	_getIcon(type) {
		let returnValue;

		switch (type) {
		case 'boolean':
			returnValue = 'text';
			break;
		case 'date':
			returnValue = 'date';
			break;
		case 'number':
			returnValue = 'number';
			break;
		case 'string':
			returnValue = 'text';
			break;
		default:
			returnValue = 'text';
		}

		return returnValue;
	}

	render() {
		const {
			className,
			connectDragSource,
			dragging,
			label,
			type
		} = this.props;

		const classes = getCN(
			'criteria-sidebar-item-root',
			{dragging},
			className,
		);

		return connectDragSource(
			<li className={classes}>
				<span className="inline-item">
					<ClayIcon iconName="drag" />
				</span>

				<span className="criteria-sidebar-item-type sticker sticker-light">
					<span className="inline-item">
						<ClayIcon iconName={this._getIcon(type)} />
					</span>
				</span>

				{label}
			</li>
		);
	}
}

export default dragSource(
	DragTypes.PROPERTY,
	{
		beginDrag
	},
	(connect, monitor) => ({
		connectDragSource: connect.dragSource(),
		dragging: monitor.isDragging()
	})
)(CriteriaSidebarItem);